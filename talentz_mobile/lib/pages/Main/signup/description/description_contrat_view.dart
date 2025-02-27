import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/signup/options/carousel_options_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';
import 'package:talentz/widgets/tab_indicator.dart';

class DescriptionContratView extends StatefulWidget {
  const DescriptionContratView({super.key});

  @override
  State<DescriptionContratView> createState() => _DescriptionContratViewState();
}

class _DescriptionContratViewState extends State<DescriptionContratView> {
  late bool activatedCDI;
  late bool activatedCDD;
  late bool activatedApprentissage;
  late bool activatedTPartiel;

  @override
  void initState() {
    super.initState();
    activatedCDI = false;
    activatedCDD = false;
    activatedApprentissage = false;
    activatedTPartiel = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: CustomColors.pink()),
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
                          top: Radius.elliptical(150, 30)),
                    ),
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
                            CustomTabIndicator(
                              activated: true,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CustomTabIndicator(
                              activated: true,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CustomTabIndicator(
                              activated: true,
                            ),
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
                                "Quel contrat ?",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Stack(alignment: Alignment.centerLeft, children: [
                                CustomButton(
                                  width: 250,
                                  onClick: () {
                                    setState(() {
                                      activatedCDI = !activatedCDI;
                                    });
                                  },
                                  heroTag: "CDIButton",
                                  decoration: BoxDecoration(
                                    color: activatedCDI
                                        ? CustomColors.pink()
                                        : Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  noAnimation: true,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 250 * 0.2,
                                  child: Center(
                                    child: Text(
                                      "CDI",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              Stack(alignment: Alignment.centerLeft, children: [
                                CustomButton(
                                  width: 250,
                                  onClick: () {
                                    setState(() {
                                      activatedCDD = !activatedCDD;
                                    });
                                  },
                                  heroTag: "CDDButton",
                                  decoration: BoxDecoration(
                                    color: activatedCDD
                                        ? CustomColors.pink()
                                        : Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  noAnimation: true,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 250 * 0.2,
                                  child: Center(
                                    child: Text(
                                      "CDD",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              Stack(alignment: Alignment.centerLeft, children: [
                                CustomButton(
                                  width: 250,
                                  onClick: () {
                                    setState(() {
                                      activatedApprentissage =
                                          !activatedApprentissage;
                                    });
                                  },
                                  heroTag: "ApprentissageButton",
                                  decoration: BoxDecoration(
                                    color: activatedApprentissage
                                        ? CustomColors.pink()
                                        : Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  noAnimation: true,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 250 * 0.45,
                                  child: Center(
                                    child: Text(
                                      "Apprentissage",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              Stack(alignment: Alignment.centerLeft, children: [
                                CustomButton(
                                  width: 250,
                                  onClick: () {
                                    setState(() {
                                      activatedTPartiel = !activatedTPartiel;
                                    });
                                  },
                                  heroTag: "TPartielButton",
                                  decoration: BoxDecoration(
                                    color: activatedTPartiel
                                        ? CustomColors.pink()
                                        : Colors.white,
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  noAnimation: true,
                                  shadowPainter: RightShadowPainter(
                                    10,
                                    radiusValue: 5,
                                    blurStrength: 0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 250 * 0.45,
                                  child: Center(
                                    child: Text(
                                      "Temps Partiel",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                )
                              ]),
                              CustomButton(
                                onClick: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CarouselOptionsView(),
                                    ),
                                  )
                                },
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      CustomColors.peach(),
                                      CustomColors.red(),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(width: 3),
                                ),
                                heroTag: "nextDescriptionNameButton",
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 50,
                                shadowPainter: RightShadowPainter(
                                  5,
                                  color: Colors.black.withOpacity(0.4),
                                  radiusValue: 100,
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
            ],
          ),
        ),
      ),
    );
  }
}
