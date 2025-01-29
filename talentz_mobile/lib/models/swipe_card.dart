import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/helpers/helpers.dart';
import 'package:talentz_mobile/widgets/fab_icon.dart';
import 'package:talentz_mobile/widgets/pill_content.dart';
import 'package:talentz_mobile/widgets/progress_bar.dart';
import 'package:talentz_mobile/widgets/right_shadow_painter.dart';
import 'package:talentz_mobile/widgets/single_child_box.dart';
import 'package:talentz_mobile/widgets/text_child_box.dart';

class SwipeCard extends StatelessWidget {
  final Map data;
  const SwipeCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.6;
    final double width = MediaQuery.of(context).size.width * 0.9;

    return Stack(children: [
      CustomPaint(
        painter: RightShadowPainter(
          7,
          color: const Color(0xFF999999),
          blurStrength: 0.8,
        ),
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
      SizedBox(
        height: height,
        width: width,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(children: [
            Column(
              children: [
                Container(
                  height: height / 3,
                  width: width,
                  decoration: BoxDecoration(
                    color: CustomColors.lightYellow(),
                    borderRadius: const BorderRadiusDirectional.vertical(
                      top: Radius.circular(17.5),
                    ),
                    border: const BorderDirectional(
                      bottom: BorderSide(color: Colors.black, width: 3),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 12.0),
                        child: Text(
                          "Score de matching",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    height: height / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          CustomColors.pink(),
                          CustomColors.peach(),
                          CustomColors.red()
                        ],
                      ),
                    ),
                    child: ListView(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  height: height / 2,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.center,
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: data["qualites"]
                                        .map(
                                          (e) => CustomTextChildBox(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            shadowPainter: RightShadowPainter(
                                              12,
                                              color: const Color(0x99999999),
                                              blurStrength: 0,
                                              radiusValue: 10,
                                            ),
                                            child: Text(
                                              e["nom"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        )
                                        .toList()
                                        .cast<Widget>(),
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SingleChildBox(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(width: 3),
                            right: BorderSide(width: 3),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(17.5),
                          )),
                      width: width / 3.2,
                      height: height / 6,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "10 ans",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "D'expérience",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 3),
                          right: BorderSide(width: 3),
                        ),
                      ),
                      width: width / 3.2,
                      height: height / 6,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+ 50",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Salariés",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 3),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(17.5),
                        ),
                      ),
                      width: width / 3.131,
                      height: height / 6,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "100%",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Satisfaction",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: height / 3,
              child: Center(
                child: PillContent(
                  width: width * 0.8,
                  height: 50,
                  color: Colors.white,
                  shadowPainter: RightShadowPainter(
                    10,
                    color: const Color(0x99999999),
                    blurStrength: 0,
                    radiusValue: 100,
                  ),
                  child: CustomProgressBar(
                    startAt: 85,
                    width: width * 0.8,
                    height: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height / 1.52,
              child: Center(
                child: SingleChildBox(
                  width: width * 0.8,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3)),
                  shadowPainter: RightShadowPainter(
                    10,
                    color: const Color(0x99999999),
                    blurStrength: 0,
                    radiusValue: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomFabIcon(
                        imagePath: CustomHelpers.cherries
                            .elementAt(data["cerise"])["icon"]
                            .toString(),
                        size: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CustomHelpers.cherries
                                  .elementAt(data["cerise"])["name"]
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              data["whyCerise"],
                              softWrap: true,
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
    ]);
  }
}
