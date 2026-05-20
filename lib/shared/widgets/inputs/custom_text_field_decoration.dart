import 'package:flutter/material.dart';

/// A utility class to provide a consistent [InputDecoration] for TextFields.
/// TODO: Refactor this into a proper CustomTextField widget if needed.
class CustomTextFieldDecoration {
  final String hintText;
  final IconData prefixIcon;

  CustomTextFieldDecoration({
    required this.hintText,
    required this.prefixIcon,
  });

  InputDecoration get decoration => InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color.fromRGBO(163, 163, 163, 1.0),
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: const Color.fromRGBO(228, 228, 228, 0.612),
        contentPadding: const EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
          left: 14.0,
          right: 14.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Color.fromRGBO(252, 148, 3, 0.605),
          ),
        ),
      );
}
