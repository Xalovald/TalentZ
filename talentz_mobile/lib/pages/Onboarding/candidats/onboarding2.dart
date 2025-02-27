import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/pages/Onboarding/candidats/onboarding3.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class Onboarding2Candidat extends StatelessWidget {
  const Onboarding2Candidat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGrey3(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: CustomColors.lightPink(),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(color: Colors.transparent),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CustomImages.radarEffect(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CustomImages.component2(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Column(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                        color: CustomColors.white(),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PillContent(
                                width: 41,
                                height: 7,
                                color: CustomColors.black(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: PillContent(
                                  width: 41,
                                  height: 7,
                                  color: CustomColors.black(),
                                ),
                              ),
                              PillContent(
                                width: 41,
                                height: 7,
                                color: CustomColors.lightGrey3(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choisis une entreprise\nqui te ressemble",
                                style: CustomTextStyles.title(
                                  color: CustomColors.black(),
                                  size: "smaller",
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Explore les valeurs et l’univers des entreprises\npour trouver celle qui partage ta vision. Ton futur\ncommence ici !",
                                style: CustomTextStyles.text(
                                    color: CustomColors.grey()),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onClick: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Onboarding3Candidat(),
                                    ),
                                  ),
                                },
                                width: 150,
                                heroTag: "onboarding2CompanyNextBtn",
                                decoration: BoxDecoration(
                                    color: CustomColors.black(),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "Suivant",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.white(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}