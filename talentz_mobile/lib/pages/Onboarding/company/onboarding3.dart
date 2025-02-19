import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/pages/Form/company/form1.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class Onboarding3Company extends StatelessWidget {
  const Onboarding3Company({super.key});

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
                  child: CustomImages.line3(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Text(
                              "Trouvez le profil qui\ncorrespond à vos",
                              style: CustomTextStyles.title(
                                color: CustomColors.black(),
                                size: "smaller",
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 165.0, top: 25),
                              child: Transform.rotate(
                                angle: -0.05,
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        CustomColors.lightPink(),
                                        CustomColors.peach(),
                                        CustomColors.red(),
                                      ],
                                      stops: const [0.07, 0.39, 0.85],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: 0.05,
                                        child: Text(
                                          "besoins !",
                                          style: CustomTextStyles.title(
                                            size: "smaller",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        CustomColors.lightBlue(),
                                        CustomColors.lighterBlue(),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: CustomColors.white(),
                                      width: 7,
                                    ),
                                    borderRadius: BorderRadius.circular(200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CustomColors.black(opacity: 0.1),
                                        offset: const Offset(2, 3),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return Center(
                                      child: CustomImages.cherry(
                                        3,
                                        width: constraints.maxWidth * 0.7,
                                        height: constraints.maxWidth * 0.7,
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  }),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        CustomColors.lightYellow(),
                                        CustomColors.yellow()
                                      ],
                                    ),
                                    border: Border.all(
                                      color: CustomColors.white(),
                                      width: 7,
                                    ),
                                    borderRadius: BorderRadius.circular(200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CustomColors.black(opacity: 0.1),
                                        offset: const Offset(2, 3),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return Center(
                                      child: CustomImages.cherry(
                                        6,
                                        width: constraints.maxWidth * 0.7,
                                        height: constraints.maxWidth * 0.7,
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: PillContent(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      CustomColors.lighterYellow(),
                                      CustomColors.darkYellow(),
                                      CustomColors.darkYellow(),
                                      CustomColors.yellow(),
                                    ],
                                    stops: const [0.08,0.28,0.66,1],
                                  ),
                                  child: Text(
                                    "Match !",
                                    style: CustomTextStyles.title(
                                      size: "smaller",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                color: CustomColors.black(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transformez votre processus de\nrecrutement.",
                                style: CustomTextStyles.title(
                                  color: CustomColors.black(),
                                  size: "smaller",
                                ),
                              ),
                              Text(
                                "Gagnez du temps et identifiez les meilleurs\ncandidats, la cerise sur le gâteaut.",
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
                                        const Form1Company(),
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
