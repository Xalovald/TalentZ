import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/pages/onboarding/company/onboarding3.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class Onboarding2Company extends StatelessWidget {
  const Onboarding2Company({super.key});

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
                  child: CustomImages.line2(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              CustomImages.blankIPhone14(
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: CustomColors.lightPink(),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomImages.cherry(2,
                                        fit: BoxFit.contain)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 36.0),
                                child: PillContent(
                                  width: 68,
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 9,
                                        height: 9,
                                        decoration: BoxDecoration(
                                            color: CustomColors.green(),
                                            borderRadius:
                                                BorderRadius.circular(200)),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PillContent(
                                            width: 36,
                                            height: 3,
                                            color: CustomColors.lightGrey2(),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1.0),
                                            child: PillContent(
                                              width: 18,
                                              height: 3,
                                              color: CustomColors.lightGrey2(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomImages.messages(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.85,
                        ),
                      ],
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
                                "Échangez en toute\ntransparence.",
                                style: CustomTextStyles.title(
                                  color: CustomColors.black(),
                                  size: "smaller",
                                ),
                              ),
                              Text(
                                "Écangez librement : exprimez vos attentes et\ndécouvrez le chemin de l'emploi tel qu'il est.",
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
                                          const Onboarding3Company(),
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
