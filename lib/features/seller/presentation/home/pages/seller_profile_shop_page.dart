import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/models/shop_model.dart';
import 'package:pawtastic/services/supabase/shop_provider.dart';
import 'package:pawtastic/shared/utils/utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/core/utils/lowercase_input_formatters.dart';
import 'package:provider/provider.dart';

class SellerProfileShopPage extends StatefulWidget {
  const SellerProfileShopPage({super.key});

  @override
  State<SellerProfileShopPage> createState() => _SellerProfileShopPageState();
}

class _SellerProfileShopPageState extends State<SellerProfileShopPage> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _slugController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isSaving = false;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    final shop = context.read<ShopProvider>().shop;
    if (shop != null) {
      _shopNameController.text = shop.shopName;
      _slugController.text = shop.storeSlug;
      _descriptionController.text = shop.description ?? '';
      _isVerified = shop.isVerified;
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveShop() async {
    setState(() => _isSaving = true);

    try {
      final shop = context.read<ShopProvider>().shop;
      if (shop == null) throw 'Shop not found';

      final updated = ShopModel(
        id: shop.id,
        ownerId: shop.ownerId,
        storeSlug: _slugController.text.trim(),
        shopName: _shopNameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        isVerified: shop.isVerified,
        status: shop.status,
        createdAt: shop.createdAt,
        updatedAt: DateTime.now(),
      );

      final success =
          await context.read<ShopProvider>().updateShop(shop.id, updated);

      if (success && mounted) {
        SnackBarUtils.show(
          context,
          context.t.seller.settings.successfully_saved_shop_profile.ucfirst(),
          type: SnackBarType.success,
        );
        Navigator.pop(context);
      } else if (mounted) {
        SnackBarUtils.show(
          context,
          context.t.seller.settings.failed_to_save_shop_profile.ucfirst(),
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      if (mounted) {
        final errorMsg = e.toString().contains("PostgrestException")
            ? "${context.t.errors.common.an_error_occured.ucfirstChar()} ${context.t.errors.common.while_saving_data}"
            : context.t.account.create_shop.an_error_occured.ucfirst();
        SnackBarUtils.show(context, errorMsg, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSaveConfirmation() {
    if (!_formKey.currentState!.validate()) {
      SnackBarUtils.show(
        context,
        context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
        type: SnackBarType.error,
      );
      return;
    }

    DialogUtils.showConfirmationDialog(
      context: context,
      title: "${context.t.seller.settings.save_shop_profile.toTitleCase()}?",
      message: context.t.common
          .make_sure_all_the_data_you_have_filled_in_is_correct
          .ucfirst(),
      onConfirm: _saveShop,
    );
  }

  void _showCancelConfirmation() {
    DialogUtils.showConfirmationDialog(
      context: context,
      title:
          "${context.t.common.cancel.ucfirst()} ${context.t.seller.settings.manage_shop_profile.toTitleCase()}?",
      message: context.t.errors.common
          .any_data_you_have_filled_will_be_lost
          .ucfirst(),
      confirmText: context.t.common.cancel.ucfirstChar(),
      cancelText: context.t.common.back.ucfirstChar(),
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.seller.settings;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showCancelConfirmation();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.centerTitle(
          context,
          blackTitle: t.manage_shop_profile.toTitleCase(),
          onBack: _showCancelConfirmation,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 20,
                      color: _isVerified ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isVerified
                          ? context.t.seller.settings.verified.ucfirst()
                          : context.t.seller.settings.not_verified.ucfirst(),
                      style: TextStyle(
                        fontSize: 13,
                        color: _isVerified ? Colors.green : Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomTextFieldRow(
                  controller: _shopNameController,
                  hintText: t.shop_name.toTitleCase(),
                  prefixIcon: Icons.store_rounded,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return context.t.errors.common.required_field
                          .ucfirstChar();
                    }
                    if (val.trim().length > 100) {
                      return context.t.errors.common
                          .maximum_character(number: 100)
                          .ucfirst();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFieldRow(
                  controller: _slugController,
                  hintText:
                      "${t.store_slug.toTitleCase()} (${context.t.seller.settings.store_slug_hint})",
                  prefixIcon: Icons.link_rounded,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9-]')),
                    LowerCaseTextFormatter(),
                  ],
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return context.t.errors.common.required_field
                          .ucfirstChar();
                    }
                    if (val.trim().length < 3) {
                      return context.t.errors.common
                          .minimum_character(number: 3)
                          .ucfirst();
                    }
                    if (val.trim().length > 50) {
                      return context.t.errors.common
                          .maximum_character(number: 50)
                          .ucfirst();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFieldRow(
                  controller: _descriptionController,
                  maxLines: 3,
                  maxLength: 1000,
                  hintText: t.description.toTitleCase(),
                  prefixIcon: Icons.description_rounded,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return context.t.errors.common.required_field
                          .ucfirstChar();
                    }
                    if (val.trim().length > 1000) {
                      return context.t.errors.common
                          .maximum_character(number: 1000)
                          .ucfirst();
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  label: t.save_shop_profile.toTitleCase(),
                  isLoading: _isSaving,
                  onPressed: _showSaveConfirmation,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
