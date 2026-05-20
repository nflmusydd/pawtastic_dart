import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';

import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:flutter/rendering.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(false);
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(bottom: 120, left: 20, right: 20),
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
            GlobalMenuItem(
              icon: Icons.person,
              text: context.t.account.index.profile.toTitleCase(),
              onTap: () {},
            ),
            GlobalMenuItem(
              icon: Icons.settings,
              text: context.t.account.index.options.toTitleCase(),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.options);
              },
            ),
            GlobalMenuItem(
              icon: Icons.store,
              text: context.t.account.index.paw_shop.toTitleCase(),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.shop);
              },
            ),
            GlobalMenuItem(
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
                  color: Color.fromRGBO(252, 147, 3, 1.0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
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
