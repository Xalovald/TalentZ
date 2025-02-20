import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/main_pages/main_page.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/assets/icons/icons.dart';

class Form10Company extends StatefulWidget {
  const Form10Company({super.key});

  @override
  State<Form10Company> createState() => _Form10CompanyState();
}

class _Form10CompanyState extends State<Form10Company> {
  late double progressBarValue;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isHintVisible = true;
  final Logger logger = Logger();
  late User user;
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://57.129.129.23:5212/api",
      connectTimeout: const Duration(seconds: 90000),
    ),
  );

  Future<void> handleButtonClick({bool setValues = true}) async {
    setValues ? user.setCerise(buttonInfos.values.singleWhere((e) => e["showText"] == true)["id"].toString()) : null;
    setValues ? user.setWhyCerise(buttonInfos.values.singleWhere((e) => e["showText"] == true)["description"]) : null;
    user.setSiret("");
    logger.i(user.toJson());
    try {
      Response response = await dio.post("/users/entreprises", data: user.toJson(), options: Options(contentType: "application/json"));
      await CustomHelpers.saveCurrentId(response.data);
    } catch (e) {
      logger.e('$e');
    }
  }

  final Map<String, Map<String, dynamic>> buttonInfos = {
    "buttonCupcake": {
      "id": 5,
      "border": CustomColors.lightGrey2(),
      "showIcon": false,
      "showText": false,
      "icon": CustomImages.cherry(5, scale: 1.2),
      "description": ""
    },
    "buttonCake": {
      "id": 6,
      "border": CustomColors.lightGrey2(),
      "showIcon": false,
      "showText": false,
      "icon": CustomImages.cherry(6, scale: 1.2),
      "description": ""
    },
    "buttonMillefeuille": {
      "id": 7,
      "border": CustomColors.lightGrey2(),
      "showIcon": false,
      "showText": false,
      "icon": CustomImages.cherry(7, scale: 1.2),
      "description": ""
    },
    "buttonPie": {
      "id": 8,
      "border": CustomColors.lightGrey2(),
      "showIcon": false,
      "showText": false,
      "icon": CustomImages.cherry(8, scale: 1.2),
      "description": ""
    },
  };
  late String previousClickedButton;
  @override
  void initState() {
    super.initState();
    progressBarValue = 8.5;
    previousClickedButton = "";
    _textController.addListener(updateHintVisibility);
    _focusNode.addListener(updateHintVisibility);
  }

  @override
  void dispose() {
    _textController.removeListener(updateHintVisibility);
    _focusNode.removeListener(updateHintVisibility);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void updateHintVisibility() {
    setState(() {
      isHintVisible = _textController.text.isEmpty && !_focusNode.hasFocus;
    });
  }

  void changeButton(String buttonKey) {
    if (buttonInfos[buttonKey]!["showText"] == false) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColors.lightYellow(),
                        borderRadius: const BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                        child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: CustomColors.white(),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bon choix ! Décrivez la raison de\nvotre choix.",
                                      style: CustomTextStyles.title(
                                        color: CustomColors.black(),
                                        size: "smaller",
                                      ),
                                    ),
                                    Text(
                                      "Même si les gâteaux ou les recettes semblent\nsimilaires, ce sont les mots et le savoir-faire de\nl’entreprise qui les rendent uniques.",
                                      style: CustomTextStyles.text(
                                        color: CustomColors.grey(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Stack(
                                    children: [
                                      TextField(
                                        controller: _textController,
                                        focusNode: _focusNode,
                                        expands: true,
                                        minLines: null,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.top,
                                        decoration: const InputDecoration(
                                          border:  OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(30),
                                        ),
                                      ),
                                      if(isHintVisible) 
                                        IgnorePointer(
                                          ignoring: true,
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 20.0),
                                                      child: Icon(
                                                        CustomIcons.cupcake,
                                                        color: CustomColors.lightGrey5(),
                                                        size: 1.4,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Avec ce que vous inspire ce gâteau, comment\ndécririez vous votre culture en trois mots ?",
                                                      style: CustomTextStyles.text(size: "smaller", color: CustomColors.lightGrey5()),
                                                    )
                                                  ]
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 20.0),
                                                      child: Icon(
                                                        CustomIcons.cupcake,
                                                        color: CustomColors.lightGrey5(),
                                                        size: 1.4,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Inspiré de ce gâteau, quelles sont les missions\nqui vous tiennent le plus à coeur ?",
                                                      style: CustomTextStyles.text(size: "smaller", color: CustomColors.lightGrey5()),
                                                    )
                                                  ]
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 20.0),
                                                      child: Icon(
                                                        CustomIcons.cupcake,
                                                        color: CustomColors.lightGrey5(),
                                                        size: 1.4,
                                                      ),
                                                    ),
                                                    Text(
                                                      "En quoi ce gâteau reflète l’ambiance de travail\ndans votre entreprise ?",
                                                      style: CustomTextStyles.text(size: "smaller", color: CustomColors.lightGrey5()),
                                                    )
                                                  ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomButton(
                              onClick: _textController.text != "" ? () => {
                                setState(() {
                                  buttonInfos[buttonKey]!["description"] = _textController.text;
                                  buttonInfos[buttonKey]!["showText"] = true;
                                }),
                                Navigator.pop(context),
                                changeButton(buttonKey),
                              } : null,
                              width: MediaQuery.of(context).size.width * 0.4,
                              heroTag: "form10CompanyModalConfirmBtn",
                              decoration: BoxDecoration(
                                  color: _textController.text != "" ? CustomColors.black() : CustomColors.lightGrey3(),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                "Confirmer",
                                style: CustomTextStyles.text(
                                  color: _textController.text != "" ? CustomColors.white() : CustomColors.grey(),
                                  bold: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ]
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * -0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightGrey1(),
                            border: Border.all(color: CustomColors.lightGrey2(), width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: buttonInfos[buttonKey]!["icon"]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      );
    }
    else {
    setState(() {
      if (previousClickedButton != buttonKey && previousClickedButton != "") {
        buttonInfos[previousClickedButton]!["showIcon"] = false;
        buttonInfos[previousClickedButton]!["showText"] = false;
        buttonInfos[previousClickedButton]!["border"] = CustomColors.lightGrey2();
      }
      buttonInfos[buttonKey]!["border"] = buttonInfos[buttonKey]!["border"] == CustomColors.lightGrey2() ? CustomColors.green() : CustomColors.lightGrey2();
      buttonInfos[buttonKey]!["showIcon"] = !buttonInfos[buttonKey]!["showIcon"];
      progressBarValue = 9;
      if(buttonInfos[buttonKey]!["showIcon"] == false) {
        buttonInfos[buttonKey]!["showText"] = false;
        progressBarValue = 8.5;
      }
      previousClickedButton = buttonKey;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.white(), // Couleur de fond de l'AppBar
        elevation: 0, // Supprimer l'ombre de l'AppBar
        automaticallyImplyLeading:
            false, // Supprimer le bouton de retour par défaut
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8),
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 9) * progressBarValue) /  MediaQuery.of(context).size.width) * 100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Créez votre profil en choisissant\nl'icône qui vous reflète le mieux",
                        style: CustomTextStyles.title(
                          color: CustomColors.black(),
                          size: "smallest",
                        ),
                      ),
                      Text(
                        "Choisissez, recherchez ou ajoutez des qualités\nqui sont importantes pour collaborer.",
                        style: CustomTextStyles.text(
                          color: CustomColors.grey(),
                          size: "smaller",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: buttonInfos.entries
                  .map((buttonInfo) => CustomButton(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        heroTag: "form10Company${RegExp(r"[A-Z][a-z]+").allMatches(buttonInfo.key).map((e) => e.group(0),).first}Button",
                        noAnimation: true,
                        onClick: () => changeButton(buttonInfo.key),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: buttonInfo.value["border"],
                            width: 2,
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: CustomColors.lightGrey1(),
                                          borderRadius: BorderRadius.vertical(
                                            top: const Radius.circular(8),
                                            bottom: Radius.circular(buttonInfo.value["showText"] ? 0 : 8),
                                          ),
                                          border: buttonInfo.value["showText"] ? Border(
                                                    bottom: BorderSide(
                                                        color: CustomColors.lightGrey2(),
                                                    ),
                                                  ) : null,
                                        ),
                                        child: buttonInfo.value["icon"],
                                      ),
                                    ),
                                    Visibility(
                                      visible:buttonInfo.value["showText"],
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SizedBox(
                                          height: constraints.maxHeight * 0.2,
                                          width: constraints.maxWidth,
                                          child: Text(
                                            buttonInfo.value["description"],
                                            style: CustomTextStyles.text(
                                                color: CustomColors.grey(),
                                                size: "smaller",
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: buttonInfo.value["showIcon"],
                                  child: Positioned(
                                    bottom: -15,
                                    left: constraints.maxWidth * 0.4,
                                    child: PillContent(
                                      width: 30,
                                      height: 30,
                                      color: CustomColors.green(),
                                      child: Icon(
                                        Icons.check,
                                        color: CustomColors.white(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: buttonInfos.entries.map((button) => button.value["showIcon"]).contains(true) ? MainAxisAlignment.end : MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: buttonInfos.entries.map((button) => button.value["showIcon"]).contains(true),
                    child: CustomButton(
                      onClick: () async {
                        await handleButtonClick();
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage("entreprise"),
                          ),
                        );
                      },
                      width: 150,
                      heroTag: "form10CompanyConfirmBtn",
                      decoration: BoxDecoration(
                          color: CustomColors.black(),
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Confirmer",
                        style: CustomTextStyles.text(
                          color: CustomColors.white(),
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: buttonInfos.entries.map((button) => button.value["showIcon"]).contains(true) ? const EdgeInsets.only(top: 16.0, bottom: 8) : const EdgeInsets.all(0),
                    child: CustomButton(
                      onClick: () async {
                        await handleButtonClick(setValues: false);
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage("entreprise"),
                          ),
                        );
                      },
                      width: 150,
                      heroTag: "form10CompanySkipBtn",
                      decoration: BoxDecoration(
                          color: CustomColors.lightGrey3(),
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Passer",
                        style: CustomTextStyles.text(
                          color: CustomColors.black(),
                          bold: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}