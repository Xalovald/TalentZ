import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';

class CustomTextStyles {
  static TextStyle title ({Color color = CustomColors.white, String family = 'Roboto'}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontFamily: family,
      fontSize: 32,
      decoration: TextDecoration.none,
    );
  }
}