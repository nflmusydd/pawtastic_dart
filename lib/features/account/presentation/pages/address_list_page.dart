import 'package:flutter/material.dart';
import 'package:pawtastic/features/account/presentation/pages/address_form_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/models/address_model.dart';
import 'package:pawtastic/services/supabase/address_provider.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:provider/provider.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar.centerTitle(
          context,
          blackTitle: context.t.address.index.my_addresses.toTitleCase(),
        ),
        body: Consumer<AddressProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: GlobalLoading());
            }

            // Filter agar tidak menampilkan alamat toko (is_shop_pickup) -> masih kurang aman jika query diubah 
            final buyerAddresses = provider.addresses
                .where((addr) => !addr.isShopPickup)
                .toList();

            if (buyerAddresses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_off_rounded, size: 80, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      context.t.address.index.no_address_found.toTitleCase(),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: buyerAddresses.length,
              itemBuilder: (context, index) {
                final address = buyerAddresses[index];
                return _buildAddressCard(address);
              },
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 20 + MediaQuery.of(context).padding.bottom,
          ),
          child: PrimaryButton(
            label: context.t.address.index.add_new_address.toTitleCase(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressFormPage()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(AddressModel address) {
    // Menggabungkan subdistrict, district, city, province untuk baris kedua
    final List<String> locationParts = [];
    if (address.subdistrictName != null) locationParts.add(address.subdistrictName!);
    if (address.districtName != null) locationParts.add(address.districtName!);
    if (address.cityName != null) locationParts.add(address.cityName!);
    if (address.provinceName != null) locationParts.add(address.provinceName!);
    
    final locationString = locationParts.join(', ');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: address.isDefaultShipping
              ? const Color.fromRGBO(252, 147, 3, 1.0)
              : Colors.grey.withOpacity(0.2),
          width: address.isDefaultShipping ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        address.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    if (address.isDefaultShipping) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(252, 147, 3, 0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          context.t.address.index.kDefault.toUpperCase(),
                          style: const TextStyle(
                            color: Color.fromRGBO(252, 147, 3, 1.0),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressFormPage(address: address),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            address.recipientName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            address.phoneNumber,
            style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat'),
          ),
          const SizedBox(height: 8),
          
          Text(
            address.fullAddress,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontFamily: 'Montserrat'),
          ),
          
          if (locationString.isNotEmpty)
            Text(
              locationString,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12, 
                fontFamily: 'Montserrat', 
                color: Colors.grey[700],
              ),
            ),
            
          if (address.zipCode != null)
            Text(
              address.zipCode!,
              style: const TextStyle(fontSize: 13, fontFamily: 'Montserrat'),
            ),
          if (!address.isDefaultShipping) ...[
            const SizedBox(height: 12),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<AddressProvider>().setDefaultAddress(address.id);
                },
                child: Text(
                  context.t.address.index.set_as_default.toTitleCase(),
                  style: const TextStyle(
                    color: Color.fromRGBO(252, 147, 3, 1.0),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
