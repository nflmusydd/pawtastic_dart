import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pawtastic/features/auth/presentation/pages/onboarding_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/splash_page.dart';
import 'package:pawtastic/features/common/presentation/pages/no_connection_page.dart';
import 'package:pawtastic/features/home/presentation/pages/home_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/seller_home_page.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _sellerModeActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getLastSellerMode().then((mode) {
        if (mounted && mode != _sellerModeActive) {
          setState(() => _sellerModeActive = mode);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (kDebugMode)
      debugPrint("AUTH_DEBUG: Role=${userProvider.role}, User=${userProvider.user}, Loading=${userProvider.isLoading}, Error=${userProvider.hasConnectionError}");

    if (userProvider.hasConnectionError) {
      return const NoConnectionPage();
    }

    // Jika masih loading, tampilkan Splash
    if (userProvider.isLoading) {
      return const SplashPage();
    }

    // Jika belum login atau session tidak valid (ghost session)
    if (userProvider.user == null || userProvider.role == UserRole.none) {
      return const OnboardingPage();
    }

    // Jika Role Seller, cek preferensi mode terakhir
    if (userProvider.role == UserRole.seller) {
      return _sellerModeActive ? const SellerHomePage() : const ToHomePage();
    }

    // Default: Ke HomePage Buyer
    return const ToHomePage();
  }
}
