import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/widgets/bottom_bar.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/shared/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';
import 'package:pawtastic/core/utils/string_extension.dart';
import 'package:pawtastic/i10n/strings.g.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Section
            Column(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/photoprofile.jpg'),
                ),
                const SizedBox(height: 10),
                // Profile Name
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return Text(
                      userProvider.fullName.isNotEmpty ? userProvider.fullName : 'User',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Menu List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  MenuItem(
                    icon: Icons.person,
                    text: context.t.account.index.profile.toTitleCase(),
                    onTap: () {},
                  ),
                  MenuItem(
                    icon: Icons.settings,
                    text: context.t.account.index.options.toTitleCase(),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.options);
                    },
                  ),
                  MenuItem(
                    icon: Icons.store,
                    text: context.t.account.index.paw_shop.toTitleCase(),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.shop);
                    },
                  ),
                  MenuItem(
                    icon: Icons.info_rounded,
                    text: context.t.account.index.about_us.toTitleCase(),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.aboutUs);
                    },
                  ),
                  const SizedBox(height: 20),
                  // Sign Out
                  Center(
                    child: CustomTextButton(
                      text: context.t.account.index.sign_out.toTitleCase(),
                      onPressed: () async {
                        await userProvider.logout();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                        }
                      },
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: const Color.fromRGBO(252, 147, 3, 1.0),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color.fromRGBO(252, 147, 3, 1.0)),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: const Color.fromRGBO(252, 147, 3, 1.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToAccountPage extends StatelessWidget {
  const ToAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 3);
  }
}
