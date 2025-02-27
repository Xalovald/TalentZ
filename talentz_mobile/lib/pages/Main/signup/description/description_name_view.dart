import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/signup/description/description_age_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/text_input.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';
import 'package:talentz/widgets/tab_indicator.dart';

class DescriptionNameView extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  DescriptionNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.pink(),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: Spacer()),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(150, 27),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.806,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(150, 30))),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox.fromSize(
                            size: const Size.fromHeight(40),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTabIndicator(activated: true),
                              SizedBox(
                                width: 15,
                              ),
                              CustomTabIndicator(),
                              SizedBox(
                                width: 15,
                              ),
                              CustomTabIndicator(),
                            ],
                          ),
                          SizedBox.fromSize(
                            size: const Size.fromHeight(40),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Comment t'appelles-tu ?",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                CustomTextInput(
                                  controller: firstNameController,
                                  placeholder: "Prénom",
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 65,
                                  textInputType: TextInputType.name,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    color: const Color(0x99999999),
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                CustomTextInput(
                                  controller: lastNameController,
                                  placeholder: "Nom",
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 65,
                                  textInputType: TextInputType.name,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    color: const Color(0x99999999),
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                CustomButton(
                                  onClick: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionAgeView()))
                                  },
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      gradient: LinearGradient(
                                          colors: [
                                            CustomColors.peach(),
                                            CustomColors.red()
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      border: Border.all(width: 3)),
                                  heroTag: "nextDescriptionNameButton",
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 50,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    color: const Color(0x99999999),
                                    radiusValue: 100,
                                    blurStrength: 0,
                                  ),
                                  child: const Text(
                                    "Suivant",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
