import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/models/address_model.dart';
import 'package:pawtastic/services/rajaongkir_service.dart';
import 'package:pawtastic/services/supabase/address_provider.dart';
import 'package:pawtastic/shared/utils/utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:provider/provider.dart';

class AddressFormPage extends StatefulWidget {
  final AddressModel? address;
  final bool isShopPickup;

  const AddressFormPage({
    super.key,
    this.address,
    this.isShopPickup = false,
  });

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _rajaOngkir = RajaOngkirService();

  late TextEditingController _titleController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _postalController;

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
  bool _isSaving = false;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isShopPickup) {
      _titleController = TextEditingController(
        text: widget.address?.title,
      );
    }
    _nameController = TextEditingController(text: widget.address?.recipientName);
    _phoneController = TextEditingController(text: widget.address?.phoneNumber);
    _addressController = TextEditingController(text: widget.address?.fullAddress);
    _postalController = TextEditingController(text: widget.address?.zipCode);
    _isDefault = widget.address?.isDefaultShipping ?? false;

    _selectedProvinceId = widget.address?.provinceId;
    _selectedProvinceName = widget.address?.provinceName;
    _selectedCityId = widget.address?.cityId;
    _selectedCityName = widget.address?.cityName;
    _selectedDistrictId = widget.address?.districtId;
    _selectedDistrictName = widget.address?.districtName;
    _selectedSubdistrictId = widget.address?.subdistrictId;
    _selectedSubdistrictName = widget.address?.subdistrictName;
    _dataSourceApi = widget.address?.api;

    _loadProvinces();
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
        if (provinces.isNotEmpty && _dataSourceApi == null) {
          _dataSourceApi = provinces.first['api']?.toString();
        }
      });

      if (_selectedProvinceId != null) {
        _loadCities(_selectedProvinceId!);
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

      if (_selectedCityId != null) {
        _loadDistricts(_selectedCityId!);
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

      if (_selectedDistrictId != null) {
        _loadSubdistricts(_selectedDistrictId!);
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
    } catch (e) {
      setState(() => _isLoadingLocations = false);
    }
  }

  Future<void> _saveAddress() async {
    // Note: Validasi Form sudah dilakukan di _showSaveConfirmation
    setState(() => _isSaving = true);

    try {
      final addressData = AddressModel(
        id: widget.address?.id ?? '',
        profileId: widget.address?.profileId ?? '',
        title: widget.isShopPickup ? (widget.address?.title ?? 'Pickup Address') : _titleController.text.trim(),
        recipientName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        fullAddress: _addressController.text.trim(),
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
        isDefaultShipping: _isDefault,
        isShopPickup: widget.isShopPickup || (widget.address?.isShopPickup ?? false),
        createdAt: widget.address?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      bool success;
      if (widget.address == null) {
        success = await context.read<AddressProvider>().addAddress(addressData);
      } else {
        success = await context.read<AddressProvider>().updateAddress(widget.address!.id, addressData);
      }

      if (success && mounted) {
        final successMsg = widget.isShopPickup
            ? "${context.t.account.create_shop.successfully_saved_shop_data.ucfirst()}"
            : "${context.t.address.form.successfully_saved_address_data.ucfirst()}";
        SnackBarUtils.show(context, successMsg, type: SnackBarType.success);
        Navigator.pop(context);
      } else {
        final errorMsg = widget.isShopPickup
            ? "${context.t.account.create_shop.failed_to_save_shop_data.ucfirst()}"
            : "${context.t.address.form.failed_to_save_address_data.ucfirst()}";
        SnackBarUtils.show(context, errorMsg, type: SnackBarType.error);
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
    // Create address seller sudah dihandle CreateShopPage
    if (!_formKey.currentState!.validate()) {
      SnackBarUtils.show(context,
          context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
          type: SnackBarType.error);
      return;
    }

    final title = widget.isShopPickup
        ? "${context.t.address.form.change_shop_address.toTitleCase()}?"
        : "${context.t.address.form.save_address.toTitleCase()}?";
    final message = widget.isShopPickup
        ? context.t.account.create_shop
            .make_sure_the_shop_data_and_pickup_address_are_correct
            .ucfirst()
        : context.t.common.make_sure_all_the_data_you_have_filled_in_is_correct
            .ucfirst();

    DialogUtils.showConfirmationDialog(
      context: context,
      title: title,
      message: message,
      onConfirm: _saveAddress,
    );
  }

  void _showCancelConfirmation() {
    DialogUtils.showConfirmationDialog(
      context: context,
      title: widget.address == null
          ? "${context.t.common.cancel.ucfirst()} ${context.t.address.form.add_address.toTitleCase()}?"
          : "${context.t.common.cancel.ucfirst()} ${context.t.address.form.change_address.toTitleCase()}?",
      message: context.t.errors.common.any_data_you_have_filled_will_be_lost.ucfirst(),
      confirmText: context.t.common.cancel.ucfirstChar(),
      cancelText: context.t.common.back.ucfirstChar(),
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    if (!widget.isShopPickup) {
      _titleController.dispose();
    }
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.address.form;

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
          blackTitle: widget.address == null
              ? context.t.address.index.add_new_address.toTitleCase()
              : context.t.address.index.edit_address.toTitleCase(),
          onBack: _showCancelConfirmation,
        ),
        body: _isLoadingLocations && _provinces.isEmpty
            ? const Center(child: GlobalLoading())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!widget.isShopPickup) ...[
                        CustomTextField(
                          controller: _titleController,
                          hintText: "${t.address_title.toTitleCase()} (${t.address_title_hint})",
                          prefixIcon: Icons.label_important_outline,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? context.t.errors.common.required_field.ucfirstChar()
                              : null,
                        ),
                        const SizedBox(height: 16),
                      ],
                      CustomTextField(
                        controller: _nameController,
                        hintText: widget.isShopPickup
                            ? t.shop_contact_name.toTitleCase()
                            : t.recipient_name.toTitleCase(),
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
                          final phoneRegex =
                              RegExp(r'^(\+62|62|0)[0-9]{8,15}$');
                          if (!phoneRegex.hasMatch(val.trim()))
                            return t.invalid_phone_number_format.ucfirstChar();
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _addressController,
                        hintText: t.full_address.toTitleCase(),
                        prefixIcon: Icons.home_outlined,
                        validator: (val) => val == null || val.trim().isEmpty
                            ? context.t.errors.common.required_field.ucfirstChar()
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Province Dropdown
                      CustomDropdown.regular(
                        labelText: t.province.toTitleCase(),
                        hintText: "${t.province.toTitleCase()}",
                        value: _selectedProvinceId,
                        isLoading: _isLoadingLocations && _provinces.isEmpty,
                        items: _provinces.map((p) {
                        final idStr = p['province_id']?.toString() ?? p['id']?.toString() ?? '0';
                          return DropdownMenuItem<int>(
                            value: int.tryParse(idStr) ?? 0,
                          child: Text((p['province'] ?? p['name']).toString(), style: const TextStyle(fontFamily: 'Montserrat')),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          final province = _provinces.firstWhere((p) {
                          final idStr = p['province_id']?.toString() ?? p['id']?.toString() ?? '0';
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

                      // City Dropdown
                      CustomDropdown.regular(
                        labelText: t.city.toTitleCase(),
                        hintText: "${t.city.toTitleCase()}",
                        value: _selectedCityId,
                        isLoading: _isLoadingLocations && _cities.isEmpty && _selectedProvinceId != null,
                        items: _cities.map((c) {
                        final idStr = c['city_id']?.toString() ?? c['id']?.toString() ?? '0';
                          return DropdownMenuItem<int>(
                            value: int.tryParse(idStr) ?? 0,
                          child: Text("${c['type'] ?? ''} ${c['city_name'] ?? c['name']}".trim(), style: const TextStyle(fontFamily: 'Montserrat')),
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

                      // District Dropdown
                      CustomDropdown.regular(
                        labelText: t.district.toTitleCase(),
                        hintText: "${t.district.toTitleCase()}",
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
                          final idStr = d['district_id']?.toString() ?? d['id']?.toString() ?? '0';
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

                      // Subdistrict Dropdown
                      CustomDropdown.regular(
                        labelText: t.subdistrict.toTitleCase(),
                        hintText: "${t.subdistrict.toTitleCase()}",
                        value: _selectedSubdistrictId,
                      isLoading: _isLoadingLocations && _subdistricts.isEmpty && _selectedDistrictId != null,
                        items: _subdistricts.map((s) {
                        final idStr = s['subdistrict_id']?.toString() ?? s['id']?.toString() ?? '0';
                          return DropdownMenuItem<int>(
                            value: int.tryParse(idStr) ?? 0,
                          child: Text((s['subdistrict_name'] ?? s['name']).toString(), style: const TextStyle(fontFamily: 'Montserrat')),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          final subdistrict = _subdistricts.firstWhere((s) {
                          final idStr = s['subdistrict_id']?.toString() ?? s['id']?.toString() ?? '0';
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

                      if (!widget.isShopPickup) ...[
                        const SizedBox(height: 10),
                        SwitchListTile(
                          title: Text(
                            context.t.address.index.set_as_default.toTitleCase(),
                            style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                          ),
                          value: _isDefault,
                          activeColor: const Color.fromRGBO(252, 147, 3, 1.0),
                          onChanged: (val) => setState(() => _isDefault = val),
                        ),
                      ],

                      const SizedBox(height: 30),
                      PrimaryButton(
                        label: t.save_address.toTitleCase(),
                        isLoading: _isSaving,
                        onPressed: _showSaveConfirmation,
                      ),

                      if (widget.address != null && !widget.isShopPickup) ...[
                        const SizedBox(height: 16),
                        DangerButton(
                          label: t.delete_address.toTitleCase(),
                          isLoading: _isSaving,
                          onPressed: () {
                            if (widget.address!.isDefaultShipping) {
                              SnackBarUtils.show(context,
                                  t.cannot_delete_default_address.ucfirst(),
                                  type: SnackBarType.error);
                              return;
                            }
                            DialogUtils.showConfirmationDialog(
                              context: context,
                              isDanger: true,
                              title: "${t.delete_address.toTitleCase()}?",
                              message: t.are_you_sure_you_want_to_delete_this_address.ucfirst(),
                              confirmText: context.t.common.confirm.toTitleCase(),
                              onConfirm: () async {
                                setState(() => _isSaving = true);
                              final success = await context.read<AddressProvider>().deleteAddress(widget.address!.id);
                                if (mounted) {
                                  setState(() => _isSaving = false);
                                  if (success) {
                                    SnackBarUtils.show(
                                        context,
                                        t.successfully_deleted_address_data.ucfirst(),
                                        type: SnackBarType.success);
                                    Navigator.pop(context);
                                  } else {
                                    SnackBarUtils.show(
                                        context,
                                        t.failed_to_delete_address_data.ucfirst(),
                                        type: SnackBarType.error);
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
