import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/models/address_model.dart';
import 'package:pawtastic/services/rajaongkir_service.dart';
import 'package:pawtastic/services/supabase/address_provider.dart';
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
  
  int? _selectedProvinceId;
  int? _selectedCityId;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.address?.title);
    _nameController = TextEditingController(text: widget.address?.recipientName);
    _phoneController = TextEditingController(text: widget.address?.phoneNumber);
    _addressController = TextEditingController(text: widget.address?.fullAddress);
    _postalController = TextEditingController(text: widget.address?.zipCode);
    _isDefault = widget.address?.isDefaultShipping ?? false;
    _selectedProvinceId = widget.address?.provinceId;
    _selectedCityId = widget.address?.cityId;

    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    setState(() => _isLoading = true);
    final provinces = await _rajaOngkir.getProvinces();
    setState(() {
      _provinces = provinces;
      _isLoading = false;
    });
    
    if (_selectedProvinceId != null) {
      _loadCities(_selectedProvinceId!);
    }
  }

  Future<void> _loadCities(int provinceId) async {
    final cities = await _rajaOngkir.getCities(provinceId);
    setState(() {
      _cities = cities;
    });
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap pilih kota")),
      );
      return;
    }

    setState(() => _isSaving = true);

    final addressData = AddressModel(
      id: widget.address?.id ?? '',
      profileId: widget.address?.profileId ?? '',
      title: _titleController.text.trim(),
      recipientName: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      fullAddress: _addressController.text.trim(),
      provinceId: _selectedProvinceId,
      cityId: _selectedCityId,
      zipCode: _postalController.text.trim(),
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

    setState(() => _isSaving = false);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.address.form;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.centerTitle(
        context,
        blackTitle: widget.address == null 
            ? context.t.address.index.add_new_address.toTitleCase()
            : context.t.address.index.edit_address.toTitleCase(),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _titleController,
                      hintText: t.address_title_hint,
                      // label: t.address_title,
                      prefixIcon: Icons.label_important_outline,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _nameController,
                      hintText: t.recipient_name_hint,
                      // label: t.recipient_name,
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: t.phone_number_hint,
                      // label: t.phone_number,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    
                    // Province Dropdown
                    _buildDropdown(
                      label: t.province,
                      value: _selectedProvinceId,
                      items: _provinces.map((p) {
                        return DropdownMenuItem<int>(
                          value: int.parse(p['province_id']),
                          child: Text(p['province'], style: const TextStyle(fontFamily: 'Montserrat')),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedProvinceId = val;
                          _selectedCityId = null;
                          _cities = [];
                        });
                        if (val != null) _loadCities(val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // City Dropdown
                    _buildDropdown(
                      label: t.city,
                      value: _selectedCityId,
                      items: _cities.map((c) {
                        return DropdownMenuItem<int>(
                          value: int.parse(c['city_id']),
                          child: Text("${c['type']} ${c['city_name']}", style: const TextStyle(fontFamily: 'Montserrat')),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _selectedCityId = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _addressController,
                      hintText: t.full_address_hint,
                      // label: t.full_address,
                      prefixIcon: Icons.home_outlined,
                      // maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _postalController,
                      hintText: t.postal_code_hint,
                      // label: t.postal_code,
                      prefixIcon: Icons.mark_as_unread_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    
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

                    const SizedBox(height: 30),
                    PrimaryButton(
                      label: t.save_address.toTitleCase(),
                      isLoading: _isSaving,
                      onPressed: _saveAddress,
                    ),
                    
                    if (widget.address != null) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            final confirm = await _showDeleteConfirm();
                            if (confirm == true && mounted) {
                              await context.read<AddressProvider>().deleteAddress(widget.address!.id);
                              if (mounted) Navigator.pop(context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(t.delete_address.toTitleCase()),
                        ),
                      ),
                    ],
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: CustomTextFieldDecoration(
            hintText: "Pilih...",
            prefixIcon: Icons.map_outlined,
          ).decoration,
          validator: (val) => val == null ? "Wajib diisi" : null,
        ),
      ],
    );
  }

  Future<bool?> _showDeleteConfirm() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.address.form.delete_address.toTitleCase()),
        content: Text(context.t.address.form.are_you_sure_you_want_to_delete_this_address),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel.toTitleCase()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              context.t.common.confirm.toTitleCase(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
