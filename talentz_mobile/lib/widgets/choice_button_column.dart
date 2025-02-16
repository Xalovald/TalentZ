import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/widgets/choice_state_chip.dart';
import 'package:talentz/widgets/button.dart';

class ChoiceButtonColumn extends StatelessWidget {
  final List<dynamic> choices;
  final String choiceButtonColumnTitle;
  final void Function()? onEditClick;

  const ChoiceButtonColumn({
    super.key,
    required this.choices,
    this.choiceButtonColumnTitle = "",
    this.onEditClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              choiceButtonColumnTitle,
              style: TextStyle(
                color: CustomColors.black(),
                fontSize: MediaQuery.of(context).size.width *0.034,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat",
              ),
            ),
            CustomButton(
              heroTag: choiceButtonColumnTitle.split(' ').join(''),
              onClick: () => onEditClick!(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: CustomColors.lightGrey7(),
              ),
              width: 40,
              height: 40,
              child: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 5,
          children: choices
              .map((choice) => ChoiceStateChip(
                    label: choice['text'],
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          width: double.maxFinite,
          color: CustomColors.lightGrey2(),
        )
      ],
    );
  }
}