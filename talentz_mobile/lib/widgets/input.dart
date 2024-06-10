import 'dart:math';

import 'package:flutter/material.dart';
import 'package:talentz_mobile/widgets/button.dart';
import 'package:talentz_mobile/widgets/fab_icon.dart';
import 'package:talentz_mobile/widgets/shadow_painter.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  final String placeholder;
  final ShadowPainter? shadowPainter;
  final Color backgroundColor;
  final TextInputType textInputType;
  final bool obscureText;

  const CustomInput(
      {super.key,
      this.height = 50,
      this.width = 100,
      this.placeholder = "",
      required this.controller,
      this.shadowPainter,
      this.backgroundColor = Colors.white,
      this.textInputType = TextInputType.text,
      this.obscureText = false});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
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
      widget.obscureText ? Container(
        alignment: Alignment.centerRight,
        width: width,
        height: height,
        child: CustomButton(
          onClick: () => setState(() {
            obscuringText = !obscuringText;
          }),
          height: height,
          isIcon: true,
          heroTag: "showHide${Random().hashCode}",
          noAnimation: true,
          icon: CustomFabIcon(iconData: obscuringText ? Icons.visibility : Icons.visibility_off, size: 24,),
        ),
      ) : const SizedBox(width: 0,height: 0,)
    ]);
  }
}
