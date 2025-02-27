import 'package:flutter/material.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class CustomButtonPost extends StatelessWidget {
  final void Function()? onClick;
  final String heroTag;
  final double width;
  final double height;
  final Decoration? decoration;
  final ShadowPainter? shadowPainter;
  final bool noAnimation;
  final Widget? child;

  const CustomButtonPost({
    super.key,
    required this.onClick,
    this.child,
    this.decoration,
    this.shadowPainter,
    required this.heroTag,
    this.width = 326,
    this.height = 60,
    this.noAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      shadowPainter != null
          ? CustomPaint(
              painter: shadowPainter,
              child: SizedBox(
                width: width,
                height: height,
              ),
            )
          : SizedBox(
              width: width,
              height: height,
            ),
      SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: decoration,
          child: Theme(
            data: ThemeData(
              highlightColor: noAnimation ? Colors.transparent : null,
              splashColor: noAnimation ? Colors.transparent : null,
            ),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: onClick,
              heroTag: heroTag,
              focusColor: noAnimation ? Colors.transparent : null,
              splashColor: noAnimation ? Colors.transparent : null,
              hoverColor: noAnimation ? Colors.transparent : null,
              highlightElevation: noAnimation ? 0 : null,
              focusElevation: noAnimation ? 0 : null,
              hoverElevation: noAnimation ? 0 : null,
              disabledElevation: noAnimation ? 0 : null,
              backgroundColor: Colors.transparent,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    ]);
  }
}