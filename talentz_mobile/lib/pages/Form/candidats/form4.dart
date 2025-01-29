import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/helpers/helpers.dart';
import 'package:talentz_mobile/pages/Form/candidats/form5.dart';
import 'package:talentz_mobile/ui/typography.dart';
import 'package:talentz_mobile/widgets/button.dart';
import 'package:talentz_mobile/widgets/progress_bar.dart';
import 'package:talentz_mobile/widgets/state_button.dart';

class Form4Candidat extends StatefulWidget {
  const Form4Candidat({super.key});
  @override
  State<Form4Candidat> createState() => _Form4CandidatState();
}

class _Form4CandidatState extends State<Form4Candidat> {
  late bool showIcon;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    showIcon = true;
  }

  void handleButtonClick(int id) {
    logger.i(id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.white(), // Couleur de fond de l'AppBar
        elevation: 0, // Supprimer l'ombre de l'AppBar
        automaticallyImplyLeading:
            false, // Supprimer le bouton de retour par défaut
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0), // Hauteur de la barre de progression
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 7) * 4) /
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
                            "Choisis les traits de personnalité qui te représentent.",
                            style: CustomTextStyles.title(
                              color: CustomColors.black(),
                              size: "smaller",
                            ),
                          ),
                          Text(
                            "Choisis, recherches ou ajoutes des qualités qui font de toi la personne que tu es.",
                            style: CustomTextStyles.text(
                              color: CustomColors.grey(),
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
                          hintText: "Conception vêtement",
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
                            spacing: 7,
                            children: CustomHelpers.personalityList
                                .map(
                                  (Map<String, dynamic> item) => StateButton(
                                    id: item["id"],
                                    onClicked: handleButtonClick,
                                    child: Text(
                                      item["name"],
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
                            builder: (context) => const Form5Candidat(),
                          ),
                        ),
                      },
                      heroTag: 'form4CandidatNextBtn',
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
