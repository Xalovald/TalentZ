import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/company/form10.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/state_button.dart';

class Form9Company extends StatefulWidget {
  const Form9Company({super.key});

  @override
  State<Form9Company> createState() => _Form9CompanyState();
}

class _Form9CompanyState extends State<Form9Company> {
  late bool showIcon;
  late List<dynamic> newList;
  final Logger logger = Logger();
  late List<dynamic> dataList = [];
  late User user;

  @override
  void initState() {
    super.initState();
    showIcon = true;
    newList = [];
    getHttp();
  }

  void handleButtonClick(dynamic id) {
    if (!user.personnalites.contains(id)) {
      user.pushToPersonnalites(id);
    } else {
      user.removeFromPersonnalites(id);
    }
    logger.i(user.personnalites);
  }

  final textController = TextEditingController();
  void onTextChange(content) {
    setState(() {
      if (content != '') {
        showIcon = false;
      } else {
        showIcon = true;
      }
      newList =
          dataList.where((dynamic e) => e["text"].contains(content)).toList();
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
      Response response = await dio.get("/personnalites");
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
          preferredSize: const Size.fromHeight(8),
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 9) * 8) /
                    MediaQuery.of(context).size.width) *
                100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choississez les traits de\npersonnalité importants",
                        style: CustomTextStyles.title(
                          color: CustomColors.black(),
                          size: "smaller",
                        ),
                      ),
                      Text(
                        "Choisissez, recherchez ou ajoutez des qualités\nqui sont importantes pour collaborer.",
                        style: CustomTextStyles.text(
                          color: CustomColors.grey(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: textController,
                    onChanged: onTextChange,
                    cursorColor: CustomColors.black(),
                    decoration: InputDecoration(
                      hintText: "Esprit disruptif",
                      hintStyle: TextStyle(color: CustomColors.lightGrey5()),
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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children:
                          (newList.isNotEmpty || textController.text.isNotEmpty
                                  ? newList
                                  : dataList)
                              .map(
                                (dynamic item) => StateButton(
                                  id: item["id"],
                                  onClicked: handleButtonClick,
                                  child: Text(
                                    item["text"],
                                    style: CustomTextStyles.text(
                                      color: CustomColors.black(),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
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
                          builder: (context) => const Form10Company(),
                        ),
                      ),
                    },
                    width: 150,
                    heroTag: "form9CompanyConfirmBtn",
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
                            builder: (context) => const Form10Company(),
                          ),
                        ),
                      },
                      width: 150,
                      heroTag: "form9CompanySkipBtn",
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
    );
  }
}
