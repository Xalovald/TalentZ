import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/candidats/form6.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';

class Form5Candidat extends StatefulWidget {
  const Form5Candidat({super.key});
  @override
  State<Form5Candidat> createState() => _Form5CandidatState();
}

class _Form5CandidatState extends State<Form5Candidat> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late Map<String, dynamic> dataList = {};
  final Logger logger = Logger();
  late User user;

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void handleButtonClick() {
    if (_textController.text != "") {
      user.setQuestionMystere({
        "id": dataList["id"],
        "reponse": _textController.text,
      });
    }
    logger.i(user.questionMystere);
  }

  void getHttp() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    try {
      Response response = await dio.get("/questions_mysteres/random");
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
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.white(),
      appBar: AppBar(
        backgroundColor: CustomColors.white(), // Couleur de fond de l'AppBar
        elevation: 0, // Supprimer l'ombre de l'AppBar
        automaticallyImplyLeading:
            false, // Supprimer le bouton de retour par défaut
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(10.0), // Hauteur de la barre de progression
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 7) * 5) /
                    MediaQuery.of(context).size.width) *
                100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 15.0,
          top: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataList.isNotEmpty ? dataList["text"] : "",
                  style: TextStyle(
                    color: CustomColors.black(),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
                const SizedBox(
                    height:
                        8), // Ajoutez un espace entre le titre et le sous-titre
                Text(
                  'Partage avec nous un accomplissement qui te rend particulièrement fier(e) !',
                  style: TextStyle(
                    color: CustomColors.grey(),
                    fontSize: 14, // Corrigé la taille de la police
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
                const SizedBox(
                    height:
                        60), // Ajoutez un espace entre le sous-titre et le TextField
                Container(
                  height: 219,
                  width: 338, // Hauteur fixe du TextField
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: CustomColors.lightGrey2(), // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    maxLines:
                        null, // Permet au TextField de s'étendre sur plusieurs lignes
                    expands:
                        true, // Permet au TextField de s'étendre pour remplir le Container
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.white(),
                      border:
                          InputBorder.none, // Supprime la bordure par défaut
                      contentPadding:
                          const EdgeInsets.all(10.0), // Padding interne
                      hintText: 'J’ai déjà réussi à faire pousser un avocat !',
                      hintStyle: TextStyle(
                        color: CustomColors.grey(),
                        fontSize: 14,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    style: TextStyle(
                      color: CustomColors.black(),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(), // Utilisez un Spacer pour pousser le bouton vers le bas
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Center(
                child: CustomButton(
                  onClick: () => {
                    handleButtonClick(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Form6Candidat(),
                      ),
                    ),
                  },
                  heroTag: 'form5CandidatNextBtn',
                  width: 180,
                  height: 52,
                  decoration: BoxDecoration(
                    color: CustomColors.black(),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Suivant',
                    style: TextStyle(
                      color: CustomColors.white(),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
