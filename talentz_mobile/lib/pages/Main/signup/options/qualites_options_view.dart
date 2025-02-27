import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/main/main_view.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/right_shadow_painter.dart';

class QualitesOptionsView extends StatefulWidget {
  const QualitesOptionsView({
    super.key,
  });

  @override
  State<QualitesOptionsView> createState() => _QualitesOptionsViewState();
}

class _QualitesOptionsViewState extends State<QualitesOptionsView> {
  late List<dynamic> dataList = [];
  late List<int> activatedElement;

  @override
  void initState() {
    super.initState();
    activatedElement = [];
    getHttp();
  }

  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  void getHttp() async {
    Dio dio = Dio(BaseOptions(
        baseUrl: "http://31.207.38.42/api",
        connectTimeout: const Duration(seconds: 90000),
        headers: {
          "ContentType": "application/json",
        }));
    try {
      Response response = await dio.get("/qualites");
      setState(() {
        dataList = response.data;
      });
    } catch (e) {
      developer.log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProgressBar(
                      startAt: 75,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 20,
                      color: Colors.white,
                    ),
                    const Text(
                      "Choisis ce qui te corresponds\nle mieux",
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "Je suis capable de :",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 20,
                  spacing: 20,
                  children: dataList.isNotEmpty
                      ? dataList
                          .map(
                            (e) => CustomButton(
                              width: e["nom"].toString().length * 10,
                              onClick: () => {
                                setState(() {
                                  activatedElement.contains(e["id"])
                                      ? activatedElement.removeWhere(
                                          (element) => element == e["id"],
                                        )
                                      : activatedElement.add(e["id"]);
                                }),
                              },
                              decoration: BoxDecoration(
                                  color: activatedElement.contains(e["id"])
                                      ? CustomColors.blue()
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 3)),
                              noAnimation: true,
                              heroTag: "qualiteButton${Random().hashCode}",
                              shadowPainter: RightShadowPainter(
                                10,
                                radiusValue: 10,
                                blurStrength: 0,
                                color: const Color(0x99999999),
                              ),
                              child: Text(
                                e["nom"].toString(),
                              ),
                            ),
                          )
                          .toList()
                      : [const CircularProgressIndicator()],
                ),
              ),
            ),
            Center(
              child: CustomButton(
                onClick: () => {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MainView()))
                },
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    gradient: LinearGradient(
                        colors: [CustomColors.peach(), CustomColors.red()],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    border: Border.all(width: 3)),
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
            ),
          ],
        ),
      ),
    );
  }
}
