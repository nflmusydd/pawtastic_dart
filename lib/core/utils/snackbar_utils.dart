import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

class SnackBarUtils {
  static void show(BuildContext context, String message, {SnackBarType type = SnackBarType.info,}) {
    // Tentukan warna dan icon berdasarkan tipe
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = const Color.fromRGBO(76, 175, 80, 1.0); 
        icon = Icons.check_circle_outline_rounded;
        break;
      case SnackBarType.error:
        backgroundColor = const Color.fromRGBO(211, 47, 47, 1.0);
        icon = Icons.error_outline_rounded;
        break;
      case SnackBarType.info:
      // ignore: unreachable_switch_default
      default:
        backgroundColor = const Color.fromRGBO(252, 147, 3, 1.0);
        icon = Icons.info_outline_rounded;
        break;
    }

    // Hapus snackbar yang sedang tampil agar tidak menumpuk
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        duration: const Duration(seconds: 3),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1), // Default flutter animation controller handling
          curve: Curves.easeOutBack,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.05,
          left: 20,
          right: 20,
        ),
      ),
    );
  }
}
