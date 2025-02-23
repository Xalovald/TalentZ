import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/candidats/form3.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button_post.dart';
import 'package:talentz/widgets/progress_bar.dart';

class Form2Candidat extends StatefulWidget {
  const Form2Candidat({super.key});

  @override
  State<Form2Candidat> createState() => _Form2CandidatState();
}

class _Form2CandidatState extends State<Form2Candidat> {
  late bool showIcon;
  late User user;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    showIcon = true;
  }

  void handleButtonClick(int id) {
    user.setTypeContrat(id);
    logger.i(user.typeContrat);
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
            startAt: (((MediaQuery.of(context).size.width / 7) * 2) /
                    MediaQuery.of(context).size.width) *
                100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
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
                          "Sélectionnes le poste que tu recherches",
                          style: CustomTextStyles.title(
                            color: CustomColors.black(),
                            size: "smaller",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 8.7),
                          child: Column(
                            children: [
                              CustomButtonPost(
                                onClick: () {
                                  handleButtonClick(1);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Form3Candidat(),
                                    ),
                                  );
                                },
                                heroTag: "CDI",
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomColors
                                        .lightGrey2(), // Couleur de la bordure
                                    width: 2.0, // Épaisseur de la bordure
                                  ),
                                  color: CustomColors.white(),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  "Contrat à durée indéterminée (CDI)",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.black(),
                                    bold: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      10), // Ajouter un espace entre les boutons
                              CustomButtonPost(
                                onClick: () {
                                  handleButtonClick(2);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Form3Candidat(),
                                    ),
                                  );
                                },
                                heroTag: "CDD",
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomColors
                                        .lightGrey2(), // Couleur de la bordure
                                    width: 2.0, // Épaisseur de la bordure
                                  ),
                                  color: CustomColors.white(),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  "Contrat à durée déterminée (CDD)",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.black(),
                                    bold: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      10), // Ajouter un espace entre les boutons
                              CustomButtonPost(
                                onClick: () {
                                  handleButtonClick(3);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Form3Candidat(),
                                    ),
                                  );
                                },
                                heroTag: "partialTime",
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomColors
                                        .lightGrey2(), // Couleur de la bordure
                                    width: 2.0, // Épaisseur de la bordure
                                  ),
                                  color: CustomColors.white(),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  "Temps partiel",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.black(),
                                    bold: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
