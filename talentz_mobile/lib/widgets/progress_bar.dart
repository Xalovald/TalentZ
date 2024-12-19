import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/widgets/pill_content.dart';

class CustomProgressBar extends StatelessWidget {
  final double startAt;
  final double height;
  final double width;
  final bool showPercentage;
  final Color color;

  const CustomProgressBar({
    super.key,
    this.startAt = 0,
    this.height = 50,
    this.width = 100,
    this.showPercentage = true,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(children: [
          PillContent(
            height: height,
            width: width * (showPercentage ? 0.7 : 0.9),
            color: color,
          ),
          Container(
            height: height,
            width: (width * (showPercentage ? 0.7 : 0.9)) * (startAt / 100),
            decoration: BoxDecoration(
              borderRadius: startAt == 100
                  ? BorderRadius.circular(100)
                  : const BorderRadius.horizontal(
                      left: Radius.circular(100),
                    ),
              gradient: const LinearGradient(
                colors: [
                  CustomColors.peach,
                  CustomColors.red,
                ],
              ),
            ),
          ),
        ]),
        showPercentage
            ? Text(
                "${startAt.ceil()}%",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              )
            : const SizedBox()
      ],
    );
  }
}
