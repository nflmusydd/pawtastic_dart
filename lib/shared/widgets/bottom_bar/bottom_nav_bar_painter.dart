import 'package:flutter/material.dart';

class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // Fill color
      ..style = PaintingStyle.fill;

    Paint outlinePaint = Paint()
      ..color = const Color.fromRGBO(252, 147, 3, 1.0) // Outline color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Outline width

    Path path = Path();
    path.moveTo(0.2, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    // Draw the shadow
    canvas.drawShadow(path, Colors.black, 5, true);
    // Draw the filled path
    canvas.drawPath(path, paint);
    // Draw the outline
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
