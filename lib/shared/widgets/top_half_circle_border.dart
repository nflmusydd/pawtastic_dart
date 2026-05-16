import 'package:flutter/material.dart';

class TopHalfCircleBorder extends ShapeBorder {
  final double strokeWidth;
  final Color outlineColor;

  const TopHalfCircleBorder({
    this.strokeWidth = 2.0,
    this.outlineColor = Colors.orange,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(strokeWidth);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // Returns the outer path of the shape (a full circle)
    Path path = Path()..addOval(rect);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double radius = rect.width / 2;

    // Create the top quarter circle (arc)
    Path path = Path()
      ..addArc(
        Rect.fromCircle(center: rect.center, radius: radius),
        -3.14 / 1, // Start angle (top of the circle)
        3.14 / 1, // End angle (half-circle, i.e., top 1/2)
      );

    // Paint the top quarter arc
    canvas.drawPath(path, paint);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // In this case, there is no inner path
    return Path(); // Returning an empty path
  }

  @override
  ShapeBorder scale(double t) {
    return TopHalfCircleBorder(
      strokeWidth: strokeWidth * t,
      outlineColor: outlineColor,
    );
  }

  // @override
  // bool shouldRepaint(ShapeBorder oldDelegate) {
  //   return false; // No need to repaint unless the shape changes
  // }
}
