import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class SellerSettingsPage extends StatefulWidget {
  const SellerSettingsPage({super.key});

  @override
  State<SellerSettingsPage> createState() => _SellerSettingsPageState();
}

class _SellerSettingsPageState extends State<SellerSettingsPage> {
  bool _notificationsEnabled = true;

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
            
          ],
        ),
      ),
    );
  }

}
