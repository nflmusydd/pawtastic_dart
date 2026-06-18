import 'package:flutter/material.dart';

class GlobalMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;

  const GlobalMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color.fromARGB(255, 245, 245, 245),
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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.05),
              //     blurRadius: 10,
              //     offset: const Offset(0, 4),
              //   ),
              // ],
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
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: const Color.fromRGBO(252, 147, 3, 1.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
