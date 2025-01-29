import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/pages/Form/company/form3.dart';
import 'package:talentz_mobile/widgets/button.dart';
import 'package:talentz_mobile/widgets/progress_bar.dart';

class Form2Company extends StatefulWidget {
  const Form2Company({super.key});
  @override
  State<Form2Company> createState() => _Form2CompanyState();
}

class _Form2CompanyState extends State<Form2Company> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNnameController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  String? _selectedSector;
  String? _selectedHeight;

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
            startAt: (((MediaQuery.of(context).size.width / 9) * 2) /
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
                  'Lorem ipsum dolor sit amet, consectetur',
                  style: TextStyle(
                    color: CustomColors.black(),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet.',
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
                            'Nom de l’entreprise',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _companyNnameController,
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
                              hintText: 'TalentZ', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize:
                                    14, // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.cake_outlined, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez entrer votre nom d'entreprise";
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
                            'Adresse',
                            style: TextStyle(
                              color: CustomColors.grey(), // Couleur du label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  "Montserrat", // Taille de la police du label
                            ),
                          ),
                          TextFormField(
                            controller: _adresseController,
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
                                  '26 avenue tourmaline...7400 Annecy', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.location_on_outlined, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse';
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
                            "Secteur d'activité",
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
                              hintText: 'Couture', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
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
                            value: _selectedSector,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSector = newValue;
                              });
                            },
                            items: <String>[
                              'Couture',
                              'Informatique',
                              'Santé',
                              'Éducation'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez sélectionner un secteur d\'activité';
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
                            "Taille de l'entreprise",
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
                              hintText: '2-10', // Ajoute un placeholder
                              hintStyle: TextStyle(
                                color: CustomColors
                                    .black(), // Couleur du placeholder
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "Montserrat", // Taille de la police du placeholder
                              ),
                              prefixIcon: Icon(
                                Icons.business, // Icône à afficher
                                color: CustomColors
                                    .lightGrey2(), // Couleur de l'icône
                              ),
                            ),
                            value: _selectedHeight,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedHeight = newValue;
                              });
                            },
                            items: <String>['2-10', '11-99', '100-999', '1000+']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez sélectionner un secteur d\'activité';
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
                      builder: (context) => const Form3Company(),
                    ),
                  ),
                },
                heroTag: 'form3CompanyNextBtn',
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
