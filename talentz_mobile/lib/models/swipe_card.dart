import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/ui/typography.dart';

class SwipeCard extends StatelessWidget {
  final Map data;

  const SwipeCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width *0.9,
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data["summary"].toString(),
                    style: CustomTextStyles.title(color: CustomColors.gold),
                  )
                ]
              ),
            )
          )
        ],
      )
    );
  }
}