import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/Company/form4.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';

class Form3Company extends StatefulWidget {
  const Form3Company({super.key});
  @override
  State<Form3Company> createState() => _Form3CompanyState();
}

class _Form3CompanyState extends State<Form3Company> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  String? _selectedRole;
  late User user;
  final Logger logger = Logger();

  void handleButtonClick() {
    user.setTelephone(_phoneController.text);
    user.setEmail(_mailController.text);
    logger.i(user.telephone);
    logger.i(user.email);
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
            startAt: (((MediaQuery.of(context).size.width / 9) * 3) /
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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Avant de commencer, nous avons besoin d’informations.',
                  style: TextStyle(
                    color: CustomColors.black(),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rôle",
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .grey()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .red()), // Couleur de la bordure en cas d'erreur
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est désactivé
                              ),
                              hintText:
                                  'CEO/Fondateur', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .grey(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.work, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            value: _selectedRole,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            items: <String>[
                              'CEO/Fondateur',
                              'Informaticien',
                              'Graphiste',
                              'Expert marketting',
                              'Communication'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez sélectionner un rôle';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Numéro de téléphone',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .grey()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .red()), // Couleur de la bordure en cas d'erreur
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est désactivé
                              ),
                              hintText:
                                  '06.26.84.29.14', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .grey(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.local_phone_outlined, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'[0-9]')), // Accepte seulement les chiffres
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre numéro de téléphone';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _mailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .grey()), // Couleur de la bordure lorsque le champ est focalisé
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .red()), // Couleur de la bordure en cas d'erreur
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure lorsque le champ est désactivé
                              ),
                              hintText:
                                  'Jhondoe@gmail.com', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .grey(), // Couleur du placeholder
                                fontSize:
                                    14, // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.alternate_email, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse mail';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: CustomButton(
                onClick: () => {
                  handleButtonClick(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Form4Company(),
                    ),
                  ),
                },
                heroTag: 'form4CompanyNextBtn',
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
          ],
        ),
      ),
    );
  }
}
