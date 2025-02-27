import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/signup/description/description_name_view.dart';
import 'package:talentz/pages/main/signup/mail_signup_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/fab_icon.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';

class SelectSignupView extends StatelessWidget {
  const SelectSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      top: Radius.elliptical(150, 30),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox.fromSize(
                        size: const Size.fromHeight(60),
                      ),
                      const Text(
                        "Créer un compte",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomButton(
                                  onClick: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionNameView()))
                                  },
                                  heroTag: "googleSignupButton",
                                  width: 275,
                                  noAnimation: true,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    blurStrength: 0,
                                    radiusValue: 5,
                                  ),
                                  child: const Text(
                                    "S'inscrire avec Google",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 275 * 0.25,
                                  child: CustomFabIcon(
                                      imagePath: "lib/assets/images/google.png",
                                      size: 20),
                                )
                              ],
                            ),
                            SizedBox.fromSize(
                              size: const Size.fromHeight(30),
                            ),
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomButton(
                                  onClick: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionNameView()))
                                  },
                                  noAnimation: true,
                                  heroTag: "appleSignupButton",
                                  width: 275,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    blurStrength: 0,
                                    radiusValue: 5,
                                  ),
                                  child: const Text(
                                    "S'inscrire avec Apple",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 275 * 0.25,
                                  child: CustomFabIcon(
                                      iconData: Icons.apple, size: 30),
                                )
                              ],
                            ),
                            SizedBox.fromSize(
                              size: const Size.fromHeight(30),
                            ),
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomButton(
                                  onClick: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MailSignupView()))
                                  },
                                  noAnimation: true,
                                  heroTag: "mailSignupButton",
                                  width: 275,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    blurStrength: 0,
                                    radiusValue: 5,
                                  ),
                                  child: const Text(
                                    "Utiliser une adresse mail",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 275 * 0.25,
                                  child: CustomFabIcon(
                                      iconData: Icons.mail_lock_outlined,
                                      size: 27),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
