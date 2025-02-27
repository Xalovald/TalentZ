import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';

class StateButton extends StatefulWidget {
  final int id;
  final Widget child;
  final ValueChanged<int>? onClicked;

  const StateButton(
      {super.key,
      required this.id,
      required this.child,
      required this.onClicked});

  @override
  State<StateButton> createState() => _StateButtonState();
}

class _StateButtonState extends State<StateButton> {
  late bool isClicked;
  void toggleColor() {
    setState(() {
      isClicked =!isClicked;
    });
    widget.onClicked!(widget.id);
  }
  @override
  void initState() {
    super.initState();
    isClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: TextButton(
        onPressed: widget.onClicked != null? toggleColor : null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(isClicked ? CustomColors.grey() : Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: CustomColors.lightGrey6(),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
