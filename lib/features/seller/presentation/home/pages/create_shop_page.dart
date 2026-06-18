import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/supabase/supabase_auth_service.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/services/supabase/address_provider.dart';
import 'package:pawtastic/services/rajaongkir_service.dart';
import 'package:pawtastic/models/address_model.dart';
import 'package:pawtastic/shared/utils/utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/auth/auth_guard.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/core/utils/lowercase_input_formatters.dart';
import 'package:provider/provider.dart';

class CreateShopPage extends StatefulWidget {
  const CreateShopPage({super.key});

  @override
  State<CreateShopPage> createState() => _CreateShopPageState();
}

class _CreateShopPageState extends State<CreateShopPage> {
  final _pageController = PageController();
  final _formKey0 = GlobalKey<FormState>(); // Form Step 0 (Shop Info)
  final _formKey1 = GlobalKey<FormState>(); // Form Step 1 (Address Info)

  int _currentStep = 0;
  bool _isLoading = false;

  // Shop Controllers
  final _shopNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _slugController = TextEditingController();

  // Address Controllers & State
  final _recipientNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullAddressController = TextEditingController();
  final _postalController = TextEditingController();

  final _rajaOngkir = RajaOngkirService();
  List<Map<String, dynamic>> _provinces = [];
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _districts = [];
  List<Map<String, dynamic>> _subdistricts = [];

  int? _selectedProvinceId;
  String? _selectedProvinceName;
  int? _selectedCityId;
  String? _selectedCityName;
  int? _selectedDistrictId;
  String? _selectedDistrictName;
  int? _selectedSubdistrictId;
  String? _selectedSubdistrictName;
  String? _dataSourceApi;

  bool _isLoadingLocations = false;

  final _authService = SupabaseAuthService();

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _shopNameController.dispose();
    _descriptionController.dispose();
    _slugController.dispose();
    _recipientNameController.dispose();
    _phoneController.dispose();
    _fullAddressController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  Future<void> _loadProvinces() async {
    setState(() => _isLoadingLocations = true);
    try {
      final provinces = await _rajaOngkir.getProvinces();
      provinces.sort((a, b) {
        final nameA = (a['province'] ?? a['name']).toString().toLowerCase();
        final nameB = (b['province'] ?? b['name']).toString().toLowerCase();
        return nameA.compareTo(nameB);
      });
      setState(() {
        _provinces = provinces;
        _isLoadingLocations = false;
        if (provinces.isNotEmpty) {
          _dataSourceApi = provinces.first['api']?.toString();
        }
      });
      if (provinces.isEmpty && mounted) {
        SnackBarUtils.show(
            context,
            "${context.t.errors.common.failed_to_load_data(
              dataName: context.t.address.form.province,
            )}. ${context.t.errors.common.please_try_again.ucfirst()}",
            type: SnackBarType.error);
      }
    } catch (e) {
      setState(() => _isLoadingLocations = false);
    }
  }

  Future<void> _loadCities(int provinceId) async {
    setState(() => _isLoadingLocations = true);
    try {
      final cities = await _rajaOngkir.getCities(provinceId);
      cities.sort((a, b) {
        final nameA = (a['city_name'] ?? a['name']).toString().toLowerCase();
        final nameB = (b['city_name'] ?? b['name']).toString().toLowerCase();
        return nameA.compareTo(nameB);
      });
      setState(() {
        _cities = cities;
        _isLoadingLocations = false;
      });
      if (cities.isEmpty && mounted) {
        SnackBarUtils.show(
            context,
            "${context.t.errors.common.failed_to_load_data(
              dataName: context.t.address.form.city,
            )}. ${context.t.errors.common.please_try_again.ucfirst()}",
            type: SnackBarType.error);
      }
    } catch (e) {
      setState(() => _isLoadingLocations = false);
    }
  }

  Future<void> _loadDistricts(int cityId) async {
    setState(() => _isLoadingLocations = true);
    try {
      final districts = await _rajaOngkir.getDistricts(cityId);
      districts.sort((a, b) {
        final nameA = (a['district_name'] ?? a['name']).toString().toLowerCase();
        final nameB = (b['district_name'] ?? b['name']).toString().toLowerCase();
        return nameA.compareTo(nameB);
      });
      setState(() {
        _districts = districts;
        _isLoadingLocations = false;
      });
      if (districts.isEmpty && mounted) {
        SnackBarUtils.show(
            context,
            "${context.t.errors.common.failed_to_load_data(
              dataName: context.t.address.form.district,
            )}. ${context.t.errors.common.please_try_again.ucfirst()}",
            type: SnackBarType.error);
      }
    } catch (e) {
      setState(() => _isLoadingLocations = false);
    }
  }

  Future<void> _loadSubdistricts(int districtId) async {
    setState(() => _isLoadingLocations = true);
    try {
      final subdistricts = await _rajaOngkir.getSubdistricts(districtId);
      subdistricts.sort((a, b) {
        final nameA = (a['subdistrict_name'] ?? a['name']).toString().toLowerCase();
        final nameB = (b['subdistrict_name'] ?? b['name']).toString().toLowerCase();
        return nameA.compareTo(nameB);
      });
      setState(() {
        _subdistricts = subdistricts;
        _isLoadingLocations = false;
      });
      if (subdistricts.isEmpty && mounted) {
        SnackBarUtils.show(
            context,
            "${context.t.errors.common.failed_to_load_data(
              dataName: context.t.address.form.subdistrict,
            )}. ${context.t.errors.common.please_try_again.ucfirst()}",
            type: SnackBarType.error);
      }
    } catch (e) {
      setState(() => _isLoadingLocations = false);
    }
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (!_formKey0.currentState!.validate()) {
        SnackBarUtils.show(
            context,
            context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
            type: SnackBarType.error);
        return;
      }
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentStep = 1);
    }
  }

  void _previousStep() {
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() => _currentStep = 0);
  }

  void _showCancelConfirmation() {
    DialogUtils.showConfirmationDialog(
      context: context,
      title: context.t.account.create_shop.cancel_creating_a_shop.toTitleCase(),
      message: context.t.errors.common.any_data_you_have_filled_will_be_lost.ucfirst(),
      confirmText: context.t.common.cancel.ucfirstChar(),
      cancelText: context.t.common.back.ucfirstChar(),
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _showFinishConfirmation() {
    if (!_formKey1.currentState!.validate()) {
      SnackBarUtils.show(context,
          context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
          type: SnackBarType.error);
      return;
    }

    DialogUtils.showConfirmationDialog(
      context: context,
      title: context.t.account.create_shop.confirmation.ucfirst(),
      message: context.t.account.create_shop.make_sure_the_shop_data_and_pickup_address_are_correct.ucfirst(),
      onConfirm: _handleFinish,
    );
  }

  Future<void> _handleFinish() async {
    setState(() => _isLoading = true);

    try {
      await _authService.createShop(
        shopName: _shopNameController.text.trim(),
        description: _descriptionController.text.trim(),
        storeSlug: _slugController.text.trim(),
      );

      final addressData = AddressModel(
        id: '',
        profileId: '',
        title: _shopNameController.text.trim(),
        recipientName: _recipientNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        fullAddress: _fullAddressController.text.trim(),
        provinceId: _selectedProvinceId,
        provinceName: _selectedProvinceName,
        cityId: _selectedCityId,
        cityName: _selectedCityName,
        districtId: _selectedDistrictId,
        districtName: _selectedDistrictName,
        subdistrictId: _selectedSubdistrictId,
        subdistrictName: _selectedSubdistrictName,
        zipCode: _postalController.text.trim(),
        api: _dataSourceApi,
        isDefaultShipping: false,
        isShopPickup: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final addressSuccess = await context.read<AddressProvider>().addAddress(addressData);

      if (addressSuccess && mounted) {
        await context.read<UserProvider>().refreshRole();
        if (mounted) {
          SnackBarUtils.show(context,
              context.t.account.create_shop.shop_created_successfully.ucfirst(),
              type: SnackBarType.success);
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.sellerHome, (route) => false);
        }
      }
      // else
    } catch (e) {
      if (mounted) {
        final errorMsg = e.toString().contains("PostgrestException")
            ? "${context.t.account.create_shop.an_error_occured.ucfirst()}. ${context.t.account.create_shop.please_try_different_store_slug.ucfirst()}"
            : context.t.errors.shop.failed_to_create_shop_please_try_again.ucfirst();
        SnackBarUtils.show(context, errorMsg, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showCancelConfirmation();
      },
      child: AuthGuard(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar.centerTitle(
            context,
            blackTitle: context.t.common.paw_shop.toTitleCase(),
            onBack: _showCancelConfirmation,
          ),
          body: Column(
            children: [
              // Step Indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Row(
                  children: [
                    _buildStepCircle(0, context.t.account.index.profile.ucfirstChar()),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(height: 2, color: Colors.grey[200]),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 2,
                            width: _currentStep >= 1 ? 500 : 0,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                    _buildStepCircle(1, context.t.common.address.ucfirstChar()),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildShopInfoStep(),
                    _buildAddressStep(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 20 + MediaQuery.of(context).padding.bottom
              ),
            child: Row(
              children: [
                if (_currentStep == 1) ...[
                  Expanded(
                    child: SecondaryButton(
                      label: context.t.common.back.ucfirstChar(),
                      onPressed: _isLoading ? null : _previousStep,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: PrimaryButton(
                    label: _currentStep == 0
                        ? context.t.common.next.ucfirstChar()
                        : context.t.common.confirm.ucfirstChar(),
                    isLoading: _isLoading,
                    onPressed:
                        _currentStep == 0 ? _nextStep : _showFinishConfirmation,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    bool isCompleted = _currentStep > step;
    bool isActive = _currentStep == step;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isActive || isCompleted) ? Colors.orange : Colors.white,
            border: Border.all(
              color: (isActive || isCompleted) ? Colors.orange : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    "${step + 1}",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.orange : Colors.grey,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }

  Widget _buildShopInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.account.create_shop.shop_profile.toTitleCase(),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            Text(
              context.t.account.create_shop.start_your_journey_with_pawtastic.ucfirst(),
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: _shopNameController,
              hintText: context.t.account.create_shop.shop_name.toTitleCase(),
              prefixIcon: Icons.store_rounded,
              validator: (val) => val == null || val.trim().isEmpty
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _slugController,
              hintText: "${context.t.account.create_shop.store_slug.toTitleCase()} ${context.t.account.create_shop.store_slug_example}",
              prefixIcon: Icons.link_rounded,
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9-]')),
                LowerCaseTextFormatter(),
              ],
              validator: (val) {
                if (val == null || val.trim().isEmpty)
                  return context.t.errors.common.required_field.ucfirstChar();
                if (val.trim().length < 3)
                  return context.t.errors.common
                      .minimum_character(number: 3)
                      .ucfirst();
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _descriptionController,
              maxLines: 3,
              maxLength: 1000,
              hintText:
                  context.t.account.create_shop.shop_description.toTitleCase(),
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressStep() {
    final t = context.t.address.form;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.account.create_shop.shop_pickup_address.toTitleCase(),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            Text(
              context.t.account.create_shop.this_address_will_be_used_by_the_courier_to_pick_up_the_order.ucfirst(),
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _recipientNameController,
              hintText: t.shop_contact_name.toTitleCase(),
              prefixIcon: Icons.person_outline,
              validator: (val) => val == null || val.trim().isEmpty
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _phoneController,
              hintText: t.phone_number.toTitleCase(),
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val == null || val.trim().isEmpty)
                  return context.t.errors.common.required_field.ucfirstChar();
                final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{8,15}$');
                if (!phoneRegex.hasMatch(val.trim()))
                  return t.invalid_phone_number_format.ucfirstChar();
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _fullAddressController,
              hintText: t.full_address.toTitleCase(),
              prefixIcon: Icons.home_outlined,
              maxLines: 3,
              validator: (val) => val == null || val.trim().isEmpty
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomDropdown.regular(
              hintText: t.province.toTitleCase(),
              value: _selectedProvinceId,
              isLoading: _isLoadingLocations && _provinces.isEmpty,
              items: _provinces.map((p) {
                final idStr = p['province_id']?.toString() ?? p['id']?.toString() ?? '0';
                return DropdownMenuItem<int>(
                  value: int.tryParse(idStr) ?? 0,
                  child: Text((p['province'] ?? p['name']).toString(),
                  style: const TextStyle(fontFamily: 'Montserrat')),
                );
              }).toList(),
              onChanged: (val) {
                if (val == null) return;
                final province = _provinces.firstWhere((p) {
                  final idStr = p['province_id']?.toString() ??
                      p['id']?.toString() ??
                      '0';
                  return (int.tryParse(idStr) ?? 0) == val;
                });
                setState(() {
                  _selectedProvinceId = val;
                  _selectedProvinceName = (province['province'] ?? province['name']).toString();
                  _selectedCityId = null;
                  _selectedCityName = null;
                  _selectedDistrictId = null;
                  _selectedDistrictName = null;
                  _selectedSubdistrictId = null;
                  _selectedSubdistrictName = null;
                  _cities = [];
                  _districts = [];
                  _subdistricts = [];
                });
                _loadCities(val);
              },
              validator: (val) => val == null
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomDropdown.regular(
              hintText: t.city.toTitleCase(),
              value: _selectedCityId,
              isLoading: _isLoadingLocations && _cities.isEmpty && _selectedProvinceId != null,
              items: _cities.map((c) {
                final idStr = c['city_id']?.toString() ?? c['id']?.toString() ?? '0';
                return DropdownMenuItem<int>(
                  value: int.tryParse(idStr) ?? 0,
                  child: Text(
                      "${c['type'] ?? ''} ${c['city_name'] ?? c['name']}".trim(),
                      style: const TextStyle(fontFamily: 'Montserrat')),
                );
              }).toList(),
              onChanged: (val) {
                if (val == null) return;
                final city = _cities.firstWhere((c) {
                  final idStr = c['city_id']?.toString() ?? c['id']?.toString() ?? '0';
                  return (int.tryParse(idStr) ?? 0) == val;
                });
                setState(() {
                  _selectedCityId = val;
                  _selectedCityName = "${city['type'] ?? ''} ${city['city_name'] ?? city['name']}".trim();
                  _selectedDistrictId = null;
                  _selectedDistrictName = null;
                  _selectedSubdistrictId = null;
                  _selectedSubdistrictName = null;
                  _districts = [];
                  _subdistricts = [];
                });
                _loadDistricts(val);
              },
              validator: (val) => val == null
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomDropdown.regular(
              hintText: t.district.toTitleCase(),
              value: _selectedDistrictId,
              isLoading: _isLoadingLocations && _districts.isEmpty && _selectedCityId != null,
              items: _districts.map((d) {
                final idStr = d['district_id']?.toString() ?? d['id']?.toString() ?? '0';
                return DropdownMenuItem<int>(
                  value: int.tryParse(idStr) ?? 0,
                  child: Text((d['district_name'] ?? d['name']).toString(),
                  style: const TextStyle(fontFamily: 'Montserrat')),
                );
              }).toList(),
              onChanged: (val) {
                if (val == null) return;
                final district = _districts.firstWhere((d) {
                  final idStr = d['district_id']?.toString() ??
                      d['id']?.toString() ??
                      '0';
                  return (int.tryParse(idStr) ?? 0) == val;
                });
                setState(() {
                  _selectedDistrictId = val;
                  _selectedDistrictName = (district['district_name'] ?? district['name']).toString();
                  _selectedSubdistrictId = null;
                  _selectedSubdistrictName = null;
                  _subdistricts = [];
                });
                _loadSubdistricts(val);
              },
              validator: (val) => val == null
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomDropdown.regular(
              hintText: t.subdistrict.toTitleCase(),
              value: _selectedSubdistrictId,
              isLoading: _isLoadingLocations && _subdistricts.isEmpty && _selectedDistrictId != null,
              items: _subdistricts.map((s) {
                final idStr = s['subdistrict_id']?.toString() ??
                    s['id']?.toString() ??
                    '0';
                return DropdownMenuItem<int>(
                  value: int.tryParse(idStr) ?? 0,
                  child: Text((s['subdistrict_name'] ?? s['name']).toString(),
                      style: const TextStyle(fontFamily: 'Montserrat')),
                );
              }).toList(),
              onChanged: (val) {
                if (val == null) return;
                final subdistrict = _subdistricts.firstWhere((s) {
                  final idStr = s['subdistrict_id']?.toString() ??
                      s['id']?.toString() ??
                      '0';
                  return (int.tryParse(idStr) ?? 0) == val;
                });
                setState(() {
                  _selectedSubdistrictId = val;
                  _selectedSubdistrictName = (subdistrict['subdistrict_name'] ?? subdistrict['name']).toString();
                });
              },
              validator: (val) => val == null
                  ? context.t.errors.common.required_field.ucfirstChar()
                  : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _postalController,
              hintText: t.postal_code.toTitleCase(),
              prefixIcon: Icons.mark_as_unread_outlined,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val == null || val.trim().isEmpty)
                  return context.t.errors.common.required_field.ucfirstChar();
                if (!RegExp(r'^[0-9]+$').hasMatch(val.trim()))
                  return t.number_only.ucfirstChar();
                if (val.trim().length < 5 || val.trim().length > 15)
                  return t.k5To15Character.ucfirstChar();
                return null;
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
