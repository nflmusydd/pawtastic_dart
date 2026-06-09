import 'package:flutter/material.dart';

class GlobalSelectionItem extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const GlobalSelectionItem({
    super.key,
    required this.title,
    this.leading,
    required this.isSelected,
    required this.onTap,
    this.activeColor = const Color.fromRGBO(252, 147, 3, 1.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isSelected
            ? Border.all(color: activeColor, width: 2)
            : Border.all(color: Colors.transparent, width: 2),
      ),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: activeColor)
            : Icon(Icons.circle_outlined, color: Colors.grey.shade300),
      ),
    );
  }
}
