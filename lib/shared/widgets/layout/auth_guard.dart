import 'package:flutter/material.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pawtastic/features/common/presentation/pages/unauthenticated_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/splash_page.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final UserRole? requiredRole;
  final String? customMessage;
  final bool allowGuest;

  const AuthGuard({
    super.key,
    required this.child,
    this.requiredRole,
    this.customMessage,
    this.allowGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isLoading) {
          return const SplashPage();
        }

        // Jika Guest diizinkan, langsung lolos untuk user null/none
        if (allowGuest && (userProvider.user == null || userProvider.role == UserRole.none)) {
          return child;
        }

        // Jika tidak ada user yang login ATAU role-nya invalid (none / ghost session)
        if (userProvider.user == null || userProvider.role == UserRole.none) {
          return UnauthenticatedPage(
            message: customMessage,
            isSeller: requiredRole == UserRole.seller,
          );
        }

        // Jika Role spesifik diminta dan tidak sesuai (misal: Buyer buka dashboard Seller)
        if (requiredRole != null && userProvider.role != requiredRole) {
          return UnauthenticatedPage(
            message: "You don't have permission to access this page.",
            isSeller: requiredRole == UserRole.seller,
          );
        }

        // lolos semua pengecekan, ke halaman asli
        return child;
      },
    );
  }
}

