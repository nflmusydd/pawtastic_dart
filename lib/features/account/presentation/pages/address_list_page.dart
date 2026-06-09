import 'package:flutter/material.dart';
import 'package:pawtastic/features/account/presentation/pages/address_form_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
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
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.addresses.isEmpty) {
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
              itemCount: provider.addresses.length,
              itemBuilder: (context, index) {
                final address = provider.addresses[index];
                return _buildAddressCard(address);
              },
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
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

  Widget _buildAddressCard(dynamic address) {
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
              Row(
                children: [
                  Text(
                    address.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
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
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  // TODO: Navigate to AddressFormPage(address: address)
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
            style: const TextStyle(fontSize: 13, fontFamily: 'Montserrat'),
          ),
          if (address.postalCode != null)
            Text(
              address.postalCode!,
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