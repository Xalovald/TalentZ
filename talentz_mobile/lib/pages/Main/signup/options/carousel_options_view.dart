import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/signup/options/why_cherry_options_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/fab_icon.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';
import 'package:talentz/widgets/single_child_box.dart';

class CarouselOptionsView extends StatefulWidget {
  const CarouselOptionsView({
    super.key,
  });

  @override
  State<CarouselOptionsView> createState() => _CarouselOptionsViewState();
}

class _CarouselOptionsViewState extends State<CarouselOptionsView> {
  late dynamic cherry;
  late CarouselControllerImpl carouselController;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    cherry = [].firstWhere(
      (element) => element["name"].toString().contains("Panier"),
    );
    carouselController = CarouselControllerImpl();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: cherry["color"] as Color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProgressBar(
                      startAt: 25,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 20,
                      color: Colors.white,
                    ),
                    const Text(
                      "Choisis la cerise qui te\ncorrespond le mieux.",
                      softWrap: true,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlutterCarousel(
                  items: []
                      .map(
                        (e) => Builder(
                          builder: (context) {
                            return SingleChildBox(
                              width: 175,
                              height: 175,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              shadowPainter: RightShadowPainter(10,
                                  color: const Color(0x99999999),
                                  radiusValue: 10,
                                  blurStrength: 0),
                              child: Center(
                                child: CustomFabIcon(
                                  imagePath: e["icon"].toString(),
                                  size: 110,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.6,
                    controller: carouselController,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) => setState(() {
                      cherry = [].elementAt(index);
                      currentIndex = index;
                    }),
                    slideIndicator: CircularSlideIndicator(
                      slideIndicatorOptions: SlideIndicatorOptions(
                        currentIndicatorColor: CustomColors.palered(),
                        indicatorBackgroundColor: const Color(0x66999999),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        width: 70,
                        onClick: () => carouselController.previousPage(),
                        heroTag: "previousCarouselButton",
                        decoration: BoxDecoration(
                          border: Border.all(width: 3),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        shadowPainter: RightShadowPainter(
                          10,
                          radiusValue: 100,
                          color: const Color(0xFF999999),
                          blurStrength: 0,
                        ),
                        child: CustomFabIcon(
                          iconData: Icons.chevron_left,
                          size: 20,
                          color: CustomColors.lightYellow(),
                        ),
                      ),
                      CustomButton(
                        width: 70,
                        onClick: () => carouselController.nextPage(),
                        heroTag: "nextCarouselButton",
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
                        child: const CustomFabIcon(
                          iconData: Icons.chevron_right,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width * 0.8,
                onClick: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WhyCherryOptionsView(
                            selectedId: currentIndex,
                          )))
                },
                heroTag: "nextViewCarouselPageButton",
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
                  "J'ai choisi !",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
