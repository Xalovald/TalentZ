import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/Company/form6.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/state_button.dart';

class Form5Company extends StatefulWidget {
  const Form5Company({super.key});

  @override
  State<Form5Company> createState() => _Form5CompanyState();
}

class _Form5CompanyState extends State<Form5Company> {
  late bool showIcon;
  final Logger logger = Logger();
  late List<dynamic> dataList = [];
  late User user;

  @override
  void initState() {
    super.initState();
    showIcon = true;
    getHttp();
  }

  void handleButtonClick(dynamic id) {
    if (!user.missions.contains(id)) {
      user.pushToMissions(id);
    } else {
      user.removeFromMissions(id);
    }
    logger.i(user.missions);
  }

  final textController = TextEditingController();
  void changeIcon(content) {
    setState(() {
      if (content != '') {
        showIcon = false;
      } else {
        showIcon = true;
      }
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
      Response response = await dio.get("/missions");
      setState(() {
        dataList = response.data;
      });
    } catch (e) {
      logger.e('$e');
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
          preferredSize:
              const Size.fromHeight(8.0), // Hauteur de la barre de progression
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 9) * 5) /
                    MediaQuery.of(context).size.width) *
                100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        top: 18.0,
                        right: 15.0,
                        bottom: 18.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ajoutez au moins 5 missions constituants le poste.",
                            style: CustomTextStyles.title(
                              color: CustomColors.black(),
                              size: "smaller",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: textController,
                        onChanged: changeIcon,
                        cursorColor: CustomColors.black(),
                        decoration: InputDecoration(
                          hintText: "Rechercher",
                          hintStyle:
                              TextStyle(color: CustomColors.lightGrey5()),
                          prefixIcon: showIcon
                              ? Icon(
                                  Icons.search,
                                  color: CustomColors.lightGrey5(),
                                )
                              : null,
                          filled: true,
                          fillColor: CustomColors.slateWhite(),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 8.7),
                      child: SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 5,
                            children: dataList
                                .map(
                                  (dynamic item) => StateButton(
                                    id: item["id"],
                                    onClicked: handleButtonClick,
                                    child: Text(
                                      item["text"],
                                      style: CustomTextStyles.text(
                                        size: "larger",
                                        color: CustomColors.black(),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    CustomButton(
                      onClick: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Form6Company()))
                      },
                      width: 150,
                      heroTag: "form5CandidatNext",
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomButton(
                        onClick: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Form6Company()),
                          ),
                        },
                        width: 150,
                        heroTag: "form5CompanyPassBtn",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
