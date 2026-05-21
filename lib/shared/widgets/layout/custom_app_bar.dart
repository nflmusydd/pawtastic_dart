import 'package:flutter/material.dart';

class CustomAppBar {
  static const _primaryColor = Color.fromRGBO(252, 147, 3, 1.0);

  // 1. Left Aligned Title
  static AppBar leftTitle(
    BuildContext context, {
    required String title,
    VoidCallback? onBack,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _primaryColor),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
    );
  }

  // 2. Centered Title
  static AppBar centerTitle(
    BuildContext context, {
    String? blackTitle,
    String? orangeTitle,
    VoidCallback? onBack,
    bool titleOnly = false,
  }) {
    // Determine height based on content: 75 for double line, default (56) for single line
    final double height = (blackTitle != null && orangeTitle != null) ? 75 : 56;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: !titleOnly,
      leading: titleOnly
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _primaryColor),
              onPressed: onBack ?? () => Navigator.pop(context),
            ),
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (blackTitle != null)
            Text(
              blackTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: orangeTitle != null ? 17.0 : 20.0,
              ),
            ),
          if (orangeTitle != null)
            Text(
              orangeTitle,
              style: const TextStyle(
                color: _primaryColor,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  // 3. Action Only / Empty Title
  static AppBar actionOnly(
    BuildContext context, {
    List<Widget>? actions,
    VoidCallback? onBack,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _primaryColor),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      actions: actions,
    );
  }
}
