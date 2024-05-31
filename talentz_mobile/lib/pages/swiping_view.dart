import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/globals/routes.dart';
import 'package:talentz_mobile/models/swipe_card.dart';
import 'package:talentz_mobile/pages/chat_view.dart';
import 'package:talentz_mobile/widgets/button.dart';

class SwipeView extends StatefulWidget {
  const SwipeView({super.key});

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> with SingleTickerProviderStateMixin {
    final CardSwiperController controller = CardSwiperController();
    late List<dynamic> dataList = [];
    late List<int> selectedList = [];
    late List<int> specialList = [];
    late List<int> disabledList = [];
    late bool special = false;

    @override
    void initState() {
      super.initState();
      getHttp();
    }

    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    void getHttp() async {
      /*Dio dio = Dio(BaseOptions(
          baseUrl: "http://37.120.204.43:5212",
          connectTimeout: const Duration(seconds: 90000),
          headers: {
            "ContentType": "application/json",
            "Authorization":
              "Basic ${stringToBase64.encode('${dotenv.env["DB_USER"]}:${dotenv.env["DB_PASSWORD"]}')}",
          }
        )
      );*/
      try {
        //Response response = await dio.get("/weatherforecast");
        setState(() {
          //dataList = json.decode(response.data);
          dataList = [
            {
              "id": 1,
              "date": "2024-05-14",
              "temperatureC": 52,
              "temperatureF": 125,
              "summary": "Balmy"
            },
            {
              "id": 2,
              "date": "2024-05-15",
              "temperatureC": 40,
              "temperatureF": 103,
              "summary": "Hot"
            },
            {
              "id": 3,
              "date": "2024-05-16",
              "temperatureC": -6,
              "temperatureF": 22,
              "summary": "Balmy"
            },
            {
              "id": 4,
              "date": "2024-05-17",
              "temperatureC": -5,
              "temperatureF": 24,
              "summary": "Bracing"
            },
            {
              "id": 5,
              "date": "2024-05-18",
              "temperatureC": 14,
              "temperatureF": 57,
              "summary": "Freezing"
            }
          ];
        });
      }
      catch (e){
        log('$e');
      }
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        backgroundColor: CustomColors.darkGrey,
        body: dataList.isNotEmpty
            ? SafeArea(
                child: Column(
                  children: [
                    Flexible(
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: dataList.length,
                        cardBuilder: (BuildContext context, index, percentThresholdX, percentThresholdY) {
                          return SwipeCard(
                            data: dataList[index],
                          );
                        },
                        onSwipe: _swipe,
                        scale: 0,
                        onEnd: () {
                          DefaultTabController.of(context).animateTo(CustomRoutes.routeNames.indexOf("ChatView"));
                        },
                        padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          CustomButton(
                            onClick: () => controller.swipe(CardSwiperDirection.left),
                            isIcon: true,
                            heroTag: "left",
                            color: CustomColors.grey,
                            icon: Icons.clear,
                            width: 75,
                            height: 75,
                            iconSize: 60,
                          ),
                          const SizedBox(width: 60),
                          CustomButton(
                            onClick: () => controller.swipe(CardSwiperDirection.right),
                            isIcon: true,
                            heroTag: "right",
                            color: CustomColors.gold,
                            icon: Icons.favorite,
                            width: 75,
                            height: 75,
                            iconSize: 50,
                          )
                        ]
                      )
                    )
                  ]
                )
            )
            : const Center(
                child: CircularProgressIndicator(),
            )
      )
    );
  }

  FutureOr<bool> _swipe(int oldIndex, int? index, CardSwiperDirection direction) {
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