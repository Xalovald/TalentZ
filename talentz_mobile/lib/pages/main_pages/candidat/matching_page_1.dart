import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:logger/logger.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/models/swipe_card.dart';
import 'package:talentz/pages/connection/signup.dart';

class MatchingPageCandidat extends StatefulWidget {
  const MatchingPageCandidat({super.key});

  @override
  State<MatchingPageCandidat> createState() => _MatchingPageCandidatState();
}

class _MatchingPageCandidatState extends State<MatchingPageCandidat>
    with SingleTickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  late List<dynamic> dataList = [];
  late List<int> selectedList = [];
  late List<int> specialList = [];
  late List<int> disabledList = [];
  late bool special = false;
  final Logger logger = Logger();

  @override void initState() {
    super.initState();
    getHttp();
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
      currId == null ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupPage())) : null;
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColors.lightYellow(),
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
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ) : const Center(child: CircularProgressIndicator()),
    );
  }

  FutureOr<bool> _swipe(
      int oldIndex, int? index, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      setState(() {
        selectedList.add(dataList[index!]["user"]["id"]);
      });
    } else if (direction == CardSwiperDirection.left) {
      setState(() {
        disabledList.add(dataList[index!]["user"]["id"]);
      });
    }
    return true;
  }
}