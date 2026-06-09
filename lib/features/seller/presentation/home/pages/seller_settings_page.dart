import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/features/account/presentation/pages/address_form_page.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pawtastic/models/address_model.dart';

class SellerSettingsPage extends StatefulWidget {
  const SellerSettingsPage({super.key});

  @override
  State<SellerSettingsPage> createState() => _SellerSettingsPageState();
}

class _SellerSettingsPageState extends State<SellerSettingsPage> {
  bool _notificationsEnabled = true;
  final _supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final t = context.t.seller.settings;

    return AuthGuard(
      requiredRole: UserRole.seller,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 250, 250),
        appBar: CustomAppBar.centerTitle(
          context,
          blackTitle: t.title.toTitleCase(),
        ),
        body: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20 + MediaQuery.of(context).padding.bottom,
          ),
          children: [
            // Notifications Toggle
            GlobalToggleItem(
              title: t.notifications.toTitleCase(),
              value: _notificationsEnabled,
              onChanged: (val) {
                setState(() => _notificationsEnabled = val);
              },
            ),
            
            const SizedBox(height: 4),
            const Divider(),
            const SizedBox(height: 4),

            // Pickup Address Menu
            GlobalMenuItem(
              icon: Icons.location_on_outlined,
              text: t.manage_pickup_address.toTitleCase(),
              onTap: _navigateToPickupAddress,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToPickupAddress() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    // Menampilkan loading sederhana
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: GlobalLoading()),
    );

    try {
      // Cari alamat yang punya is_shop_pickup = true untuk user ini
      final data = await _supabase
          .from('addresses')
          .select()
          .eq('profile_id', userId)
          .eq('is_shop_pickup', true)
          .filter('deleted_at', 'is', null)
          .maybeSingle();

      if (!mounted) return;
      Navigator.pop(context); // Tutup loading

      AddressModel? address;
      if (data != null) {
        address = AddressModel.fromJson(data);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressFormPage(
            address: address,
            isShopPickup: true,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Tutup loading
        if (kDebugMode) debugPrint("Can't read pickup addresses: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.t.seller.settings.cant_reach_your_address.ucfirst())),
        );
      }
    }
  }
}
