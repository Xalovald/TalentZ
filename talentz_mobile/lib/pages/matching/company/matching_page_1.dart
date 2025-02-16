import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/svgs/svg_images.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/models/swipe_card.dart';
import 'package:talentz/pages/Onboarding/splash.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';

class MatchingPageCompany extends StatefulWidget {
  const MatchingPageCompany({super.key});

  @override
  State<MatchingPageCompany> createState() => _MatchingPageCompanyState();
}

class _MatchingPageCompanyState extends State<MatchingPageCompany>
    with SingleTickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  late List<dynamic> dataList = [];
  int _selectedIndex = 2; // Index sélectionné par défaut pour 'Matching'
  late List<int> selectedList = [];
  late List<int> specialList = [];
  late List<int> disabledList = [];
  late bool special = false;
  final Logger  logger = Logger();

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getHttp() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    try {
      int? currId = await CustomHelpers.getCurrentId();
      if(!mounted) return;
      currId == null ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashPage())) : null;
        Response response  = await dio.get("/matching", data: {"idUser": currId});
        setState(() {
          dataList = response.data;
          logger.i(response.data.toString());
        });
    }
    catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white(),
      body: dataList.isNotEmpty ? Stack(
        children: [
          // Background Container with Blur
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColors.lightBlue(),
              borderRadius: const BorderRadius.all(Radius.circular(200)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // Foreground Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CardSwiper(
                    controller: controller,
                    cardsCount: dataList.length,
                    cardBuilder: (BuildContext context, index,
                        percentThresholdX, percentThresholdY) {
                      return SwipeCard(
                        data: dataList[index],
                      );
                    },
                    onSwipe: _swipe,
                    scale: 0,
                    onEnd: () {},
                    padding: const EdgeInsets.only(right: 0, left: 0),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onClick: () => controller.swipe(CardSwiperDirection.left),
                      heroTag: "swipeCompanyLeft",
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.palered(),
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Center(
                          child: Icon(
                            Icons.close,
                            color: CustomColors.white(),
                            size: constraints.maxWidth * 0.4,
                          ),
                        );
                      }),
                    ),
                    CustomButton(
                      onClick: () => controller.swipe(CardSwiperDirection.right),
                      heroTag: "swipeCompanyRight",
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.green(),
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Center(
                          child: Icon(
                            Icons.card_travel_rounded,
                            color: CustomColors.white(),
                            size: constraints.maxWidth * 0.4,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ) : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: Container(
        height: 103,
        width: 390,
        decoration: BoxDecoration(
          color: CustomColors.white(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -2), // Ombre vers le haut
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: CustomColors.white(),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              _buildBottomNavigationBarItem(
                  0,
                  CustomSvgImages.notificationsNotSelected(
                      height: 25, width: 25),
                  CustomSvgImages.notificationsSelected(height: 25, width: 25),
                  "Notifications"),
              _buildBottomNavigationBarItem(
                  1,
                  CustomSvgImages.msgNotSelected(height: 25, width: 25),
                  CustomSvgImages.msgSelected(height: 25, width: 25),
                  "Echanges"),
              _buildBottomNavigationBarItem(
                  2,
                  CustomSvgImages.matchingNotSelected(height: 25, width: 25),
                  CustomSvgImages.matchingSelected(height: 25, width: 25),
                  "Matching"),
              _buildBottomNavigationBarItem(
                  3,
                  CustomSvgImages.profilNotSelected(height: 25, width: 25),
                  CustomSvgImages.profilSelected(height: 25, width: 25),
                  "Profil"),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    int index,
    SvgPicture notSelectedIcon,
    SvgPicture selectedIcon,
    String label,
  ) {
    bool isSelected = index == _selectedIndex;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7.5),
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColors.red().withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected ? selectedIcon : notSelectedIcon,
            const SizedBox(height: 5), // Espace entre l'icône et le label
            Text(
              label,
              style: CustomTextStyles.text(
                size: "smalest",
                color: CustomColors.black(),
                bold: isSelected,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      label: '', // Laisser vide car le texte est dans le Column
    );
  }

  FutureOr<bool> _swipe(
      int oldIndex, int? index, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      setState(() {
        selectedList.add(dataList.toList()[index!]["user"]["id"]);
      });
    } else if (direction == CardSwiperDirection.left) {
      setState(() {
        disabledList.add(dataList.toList()[index!]["user"]["id"]);
      });
    }
    return true;
  }
}
