import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/pages/Form/candidats/form1.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class Onboarding3Candidat extends StatelessWidget {
  const Onboarding3Candidat({super.key});

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
                padding: const EdgeInsets.only(top: 165),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CustomImages.frame1531(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Column(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
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
                                color: CustomColors.black(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Échange librement avec les\nrecruteurs",
                                style: CustomTextStyles.title(
                                  color: CustomColors.black(),
                                  size: "smaller",
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Discute directement avec les recruteurs et pose\ntoutes tes questions. ",
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
                                          const Form1Candidat(),
                                    ),
                                  ),
                                },
                                width: 150,
                                heroTag: "onboarding3CompanyBeginBtn",
                                decoration: BoxDecoration(
                                    color: CustomColors.black(),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "Commencer",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.white(),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}