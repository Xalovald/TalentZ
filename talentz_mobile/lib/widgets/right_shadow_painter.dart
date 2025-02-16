import 'package:flutter/material.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class RightShadowPainter extends ShadowPainter {
  final double elevation;
  final Color color;
  final double radiusValue;
  final double blurStrength;

  RightShadowPainter(this.elevation,
      {Color? color, this.radiusValue = 20, this.blurStrength = 1})
      : color = color ?? Colors.black.withOpacity(0.25);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation / (2 / blurStrength));

    final rect = Rect.fromLTWH(elevation, elevation, size.width, size.height);
    final radius = Radius.circular(radiusValue);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
