import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';

class CustomTabIndicator extends StatelessWidget {
  final bool activated;

  const CustomTabIndicator({
    super.key,
    this.activated = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 15,
      child: Container(
        decoration: BoxDecoration(
          color: activated == false ? const Color(0x99999999) : null,
          gradient: activated
              ? const LinearGradient(
                  colors: [CustomColors.orange, CustomColors.red],
                )
              : null,
          borderRadius: BorderRadius.circular(100)
        ),
      ),
    );
  }
}
