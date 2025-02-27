import 'package:flutter/material.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class PillContent extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final ShadowPainter? shadowPainter;
  final Gradient? gradient;
  final Widget? child;

  const PillContent({
    super.key,
    this.width = 100,
    this.height = 50,
    this.color = Colors.white,
    this.gradient,
    this.shadowPainter,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomPaint(
        painter: shadowPainter,
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: gradient == null ? color : null,
          gradient: gradient ?? gradient,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: child),
      ),
    ]);
  }
}
