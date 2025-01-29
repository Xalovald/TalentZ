import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/pages/Form/company/form2.dart';
import 'package:talentz_mobile/widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:talentz_mobile/widgets/progress_bar.dart';

class Form1Company extends StatefulWidget {
  const Form1Company({super.key});
  @override
  State<Form1Company> createState() => _Form1CompanyState();
}

class _Form1CompanyState extends State<Form1Company> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            startAt: (((MediaQuery.of(context).size.width / 9) * 1) /
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet',
                  style: TextStyle(
                    color: CustomColors.grey(),
                    fontSize: 14, // Corrigé la taille de la police
                    fontWeight: FontWeight.w500,
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
                            'Prénom',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: CustomColors
                                        .lightGrey2()), // Couleur de la bordure
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
                              hintText: 'Jhon', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize:
                                    14, // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.person, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prénom';
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
                            'Nom',
                            style: TextStyle(
                              color:
                                  CustomColors.lightGrey2(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _lastNameController,
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
                              hintText: 'Doe', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.person, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
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
                            'Âge',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _ageController,
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
                              hintText: '25', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.cake_outlined, // Icône à afficher
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
                                return 'Veuillez entrer votre âge';
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
                                    .black(), // Couleur du placeholder
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
                                    .black(), // Couleur du placeholder
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Form2Company(),
                    ),
                  ),
                },
                heroTag: 'form2CompanyNextBtn',
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
