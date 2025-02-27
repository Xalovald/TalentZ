import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/signup/options/qualites_options_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/fab_icon.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';
import 'package:talentz/widgets/single_child_box.dart';
import 'package:talentz/widgets/text_input.dart';

class WhyCherryOptionsView extends StatefulWidget {
  final int selectedId;
  const WhyCherryOptionsView({
    super.key,
    required this.selectedId,
  });

  @override
  State<WhyCherryOptionsView> createState() => _WhyCherryOptionsViewState();
}

class _WhyCherryOptionsViewState extends State<WhyCherryOptionsView> {
  late int selectedId;
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    selectedId = widget.selectedId;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: CustomColors.pink(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomProgressBar(
                        startAt: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 20,
                        color: Colors.white,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pourquoi l'avoir\nsélectionnée ?",
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            "Ta réponse sera visible par les recruteurs\nlors du matchmaking.",
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildBox(
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                            color: CustomColors.pink(),
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        shadowPainter: RightShadowPainter(10,
                            color: const Color(0x99999999),
                            radiusValue: 10,
                            blurStrength: 0),
                        child: Center(
                          child: CustomFabIcon(
                            imagePath:
                                [].elementAt(selectedId)["icon"].toString(),
                            size: 110,
                          ),
                        ),
                      ),
                      CustomTextInput(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.8,
                        controller: textEditingController,
                        placeholder: "Réponse",
                        shadowPainter: RightShadowPainter(10,
                            radiusValue: 10, blurStrength: 0),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: CustomButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  onClick: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QualitesOptionsView()))
                  },
                  heroTag: "nextWhyCherryOptionsButton",
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      colors: [
                        CustomColors.peach(),
                        CustomColors.red(),
                      ],
                    ),
                  ),
                  shadowPainter: RightShadowPainter(
                    10,
                    radiusValue: 100,
                    color: const Color(0xFF999999),
                    blurStrength: 0,
                  ),
                  child: const Text(
                    "Suivant",
                    style: TextStyle(color: Colors.white),
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
