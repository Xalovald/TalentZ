import 'package:flutter/material.dart';
import 'package:talentz/widgets/pill_content.dart';

class CustomProgressBar extends StatelessWidget {
  final double startAt;
  final double height;
  final double width;
  final Color color;

  const CustomProgressBar({
    super.key,
    this.startAt = 0,
    this.height = 50,
    this.width = 100,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PillContent(
        height: height,
        width: width * 0.9,
        color: color,
      ),
      Container(
        height: height,
        width: (width * 0.9) * (startAt / 100),
        decoration: BoxDecoration(
          borderRadius: startAt == 100
              ? BorderRadius.circular(100)
              : const BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
          color: Colors.black,
        ),
      ),
    ]);
  }
}
