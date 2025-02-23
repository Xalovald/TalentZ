import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/candidats/form2.dart';
import 'package:talentz/widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:talentz/widgets/progress_bar.dart';

class Form1Candidat extends StatefulWidget {
  const Form1Candidat({super.key});
  @override
  State<Form1Candidat> createState() => _Form1CandidatState();
}

class _Form1CandidatState extends State<Form1Candidat> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPwd = false;

  late User user;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  void handleButtonClick() {
    user.setFirstName(_firstNameController.text);
    user.setLastName(_lastNameController.text);
    user.setEmail(_mailController.text);
    user.setTelephone(_phoneController.text);
    user.setDateNaissance(DateTime.now()
        .subtract(Duration(days: int.parse(_ageController.text) * 365))
        .toString()
        .split(" ")[0]);
    user.setPassword(_passwordController.text);
    logger.i(user.firstName);
    logger.i(user.lastName);
    logger.i(user.email);
    logger.i(user.telephone);
    logger.i(user.dateNaissance);
    logger.i(user.password);
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
            startAt: (((MediaQuery.of(context).size.width / 7) * 1) /
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
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
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
                                    .grey(), // Couleur du placeholder
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
                                    .grey(), // Couleur du placeholder
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
                                    .grey(), // Couleur du placeholder
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
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mot de passe',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: showPwd ? false : true,
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
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .grey(), // Couleur du placeholder
                                fontSize:
                                    14, // Taille de la police du placeholder
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPwd = !showPwd;
                                    });
                                  },
                                  child: Icon(
                                    showPwd
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: CustomColors.lightGrey2(),
                                  )),
                              prefixIcon: Icon(
                                Icons.password_outlined, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un mot de passe';
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
                      builder: (context) => const Form2Candidat(),
                    ),
                  ),
                },
                heroTag: 'form1CandidatNextBtn',
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
