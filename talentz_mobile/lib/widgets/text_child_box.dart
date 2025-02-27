import 'package:flutter/material.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class CustomTextChildBox extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;
  final Decoration? decoration;
  final ShadowPainter? shadowPainter;

  const CustomTextChildBox({
    super.key,
    required this.child,
    this.width = 100,
    this.height = 50,
    this.decoration,
    this.shadowPainter,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: shadowPainter,
          child: IntrinsicWidth(
            child: SizedBox(
                height: height,
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: child,
                  ),
                )),
          ),
        ),
        Container(
          height: height,
          decoration: decoration,
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(child: child),
            ),
          ),
        )
      ],
    );
  }
}
