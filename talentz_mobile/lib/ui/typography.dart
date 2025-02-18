import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle title({Color color = Colors.white, String family = 'Montserrat', String size = "normal", bool shadow = false, underline = false}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontFamily: family,
      fontSize: size == "smallest" ? 18.5 : size == "smaller" ? 20 : size == "larger" ? 32 : size == "none" ? null : 25,
      decoration: TextDecoration.none,
      shadows: shadow ? const [
        Shadow(color: Colors.black, offset: Offset(1, 0.5), blurRadius: 1),
      ] : [],
      decorationStyle: underline ? TextDecorationStyle.solid : null,
      decorationColor: underline ? color : null,
      decorationThickness: underline ? 2 : null
    );
  }
  static TextStyle text({Color color = Colors.white, String family = 'Montserrat', String size = "normal", bold = false, bool shadow = false, underline = false}) {
    return TextStyle(
      color: color,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      fontFamily: family,
      fontSize: size == "smaller" ? 10 : size == "larger" ? 14 : 12,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      shadows: shadow ? const [
        Shadow(color: Colors.black, offset: Offset(1, 0.5), blurRadius: 1),
      ] : [],
      decorationColor: underline ? color : null,
    );
  }
}