import 'package:flutter/material.dart';

import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class DialogUtils {
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
  }) async {
    const primaryColor = Color.fromRGBO(252, 147, 3, 1.0);
    
    // Default values using translations (runtime)
    final effectiveTitleText = title ?? context.t.common.confirm.toTitleCase();
    final effectiveConfirmText = confirmText ?? context.t.common.yes.toTitleCase();
    final effectiveCancelText = cancelText ?? context.t.common.cancel.toTitleCase();
    final effectiveMessage = message ?? "";

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            effectiveTitleText,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            effectiveMessage,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                effectiveCancelText,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                effectiveConfirmText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
