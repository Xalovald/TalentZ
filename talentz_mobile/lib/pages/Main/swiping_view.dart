import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talentz/globals/routes.dart';
import 'package:talentz/models/swipe_card.dart';
import 'package:talentz/widgets/button.dart';

class SwipeView extends StatefulWidget {
  const SwipeView({super.key});

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> with SingleTickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  late List<dynamic> dataList = [
    {
      "qualites": [
        {
          "nom": "test"
        }
      ],
      "cerise": 0,
      "whyCerise": "panier"
    }
  ];
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
    Dio dio = Dio(BaseOptions(
        baseUrl: "http://31.207.38.42/api",
        connectTimeout: const Duration(seconds: 90000),
        headers: {
          "ContentType": "application/json",
          "Authorization":
              "Basic ${stringToBase64.encode('${dotenv.env["DB_USER"]}:${dotenv.env["DB_PASSWORD"]}')}",
        }));
    try {
      Response response = await dio.get("/users");
      setState(() {
        dataList = response.data;
      });
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataList.isNotEmpty
          ? SafeArea(
              child: Column(children: [
                SizedBox.fromSize(size: const Size.fromHeight(10)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommandation du jour",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ces profils correspondent à votre recherche",
                        style: TextStyle(
                          fontSize: 12
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
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
                    padding:
                        const EdgeInsets.only(top: 24.0, left: 24, right: 24),
                  ),
                ),
                CustomButton(
                  heroTag: "testButton",
                  onClick: () => controller.swipe(CardSwiperDirection.right),
                )
              ]),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
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
