import 'package:flutter/material.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class SingleChildBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final ShadowPainter? shadowPainter;
  final Decoration? decoration;

  const SingleChildBox({
    super.key,
    this.width = 100,
    this.height = 50,
    required this.child,
    this.shadowPainter,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: shadowPainter,
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: decoration,
          child: child,
        )
      ],
    );
  }
}
