import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text_field_decoration.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? label;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double width;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.width = 350,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              color: Colors.black,
            ),
            decoration: CustomTextFieldDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
              ).decoration.copyWith(
                suffixIcon: suffixIcon,
                // Jika maxLines > 1, atur icon agar tetap di atas (top alignment)
                prefixIcon: maxLines > 1
                  ? Transform.translate(
                      // Geser sumbu Y ke arah negatif untuk menaikkan icon. 
                      // Silakan ubah angka -12 ini (misal -14 atau -16) sampai benar-benar lurus dengan hintText.
                      offset: const Offset(0, -22), 
                      child: Icon(
                        prefixIcon,
                        color: Colors.grey.shade700,
                      ),
                    )
                  : Icon(prefixIcon),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
              ),
          ),
        ),
      ],
    );
  }
}
