import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/fab_icon.dart';
import 'package:talentz/widgets/shadow_painter.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  final String placeholder;
  final ShadowPainter? shadowPainter;
  final Color backgroundColor;
  final TextInputType textInputType;
  final bool obscureText;

  const CustomTextInput({
    super.key,
    this.height = 50,
    this.width = 100,
    this.placeholder = "",
    required this.controller,
    this.shadowPainter,
    this.backgroundColor = Colors.white,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  State<CustomTextInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomTextInput> {
  late final ShadowPainter? shadowPainter;
  late final double width;
  late final double height;
  late final TextEditingController controller;
  late final TextInputType textInputType;
  late final Color backgroundColor;
  late final String placeholder;
  late bool obscuringText;

  @override
  void initState() {
    super.initState();
    shadowPainter = widget.shadowPainter;
    width = widget.width;
    height = widget.height;
    controller = widget.controller;
    textInputType = widget.textInputType;
    backgroundColor = widget.backgroundColor;
    placeholder = widget.placeholder;
    obscuringText = widget.obscureText;
  }

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
        height: height,
        width: width,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          inputFormatters: <TextInputFormatter>[
            textInputType == TextInputType.number
                ? FilteringTextInputFormatter.digitsOnly
                : TextInputFormatter.withFunction(
                    (oldValue, newValue) => newValue,
                  ),
          ],
          textAlignVertical: TextAlignVertical.center,
          obscureText: obscuringText,
          decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              hintText: placeholder,
              alignLabelWithHint: true,
              border: const OutlineInputBorder(),
              hintMaxLines: 1,
              hintStyle: const TextStyle()),
        ),
      ),
      widget.obscureText
          ? Container(
              alignment: Alignment.centerRight,
              width: width,
              height: height,
              child: CustomButton(
                onClick: () => setState(() {
                  obscuringText = !obscuringText;
                }),
                height: height,
                heroTag: "showHide${Random().hashCode}",
                noAnimation: true,
                child: CustomFabIcon(
                  iconData:
                      obscuringText ? Icons.visibility : Icons.visibility_off,
                  size: 24,
                ),
              ),
            )
          : const SizedBox(
              width: 0,
              height: 0,
            )
    ]);
  }
}
