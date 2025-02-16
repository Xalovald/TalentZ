import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/ui/typography.dart';

class ChoiceStateChip extends StatefulWidget {
  final String label;

  const ChoiceStateChip({
    super.key,
    required this.label,
  });

  @override
  State<ChoiceStateChip> createState() => _ChoiceStateChipState();
}

class _ChoiceStateChipState extends State<ChoiceStateChip> {
  late bool isClicked;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.lightGrey7(),
            border: Border.all(color: CustomColors.lightGrey6()),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: CustomTextStyles.text(
                    size: "larger",
                    color: CustomColors.black(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}