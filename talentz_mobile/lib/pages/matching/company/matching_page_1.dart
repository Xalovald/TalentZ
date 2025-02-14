import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/assets/images/svgs/svg_images.dart';
import 'package:talentz_mobile/globals/routes.dart';
import 'package:talentz_mobile/models/swipe_card.dart';
import 'package:talentz_mobile/ui/typography.dart';

class MatchingPageCompany extends StatefulWidget {
  const MatchingPageCompany({super.key});

  @override
  State<MatchingPageCompany> createState() => _MatchingPageCompanyState();
}

class _MatchingPageCompanyState extends State<MatchingPageCompany>
    with SingleTickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  late List<dynamic> dataList = [
    {
      "qualites": [
        {"nom": "test"}
      ],
      "cerise": 0,
      "whyCerise": "panier",
      "competences": [
        {
          "id": 1,
          "text": "test",
        }
      ],
      "softskills": [
        {
          "id": 1,
          "text": "test",
        }
      ],
    },
    {
      "qualites": [
        {"nom": "test"}
      ],
      "cerise": 0,
      "whyCerise": "panier",
      "competences": [
        {
          "id": 2,
          "text": "test2",
        }
      ],
      "softskills": [
        {
          "id": 2,
          "text": "test2",
        }
      ],
    }
  ];
  int _selectedIndex = 2; // Index sélectionné par défaut pour 'Matching'
  late List<int> selectedList = [];
  late List<int> specialList = [];
  late List<int> disabledList = [];
  late bool special = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white(),
      body: Stack(
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
                    onEnd: () {
                      DefaultTabController.of(context).animateTo(
                          CustomRoutes.routeNames.indexOf("ChatView"));
                    },
                    padding: const EdgeInsets.only(right: 0, left: 0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
              color: Colors.grey.withValues(alpha: 0.5),
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
        selectedList.add(dataList.toList()[index!]["id"]);
      });
    } else if (direction == CardSwiperDirection.left) {
      setState(() {
        disabledList.add(dataList.toList()[index!]["id"]);
      });
    }
    return true;
  }
}
