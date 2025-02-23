import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/company/form3.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/progress_bar.dart';

class Form2Company extends StatefulWidget {
  const Form2Company({super.key});
  @override
  State<Form2Company> createState() => _Form2CompanyState();
}

class _Form2CompanyState extends State<Form2Company> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  int _selectedSector = 0;
  int _selectedHeight = 0;
  late List<dynamic> _sizeList;
  late List<dynamic> _sectorList;
  late User user;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _sizeList = [];
    _sectorList = [];
    getHttp();
  }

  void handleButtonClick() {
    user.setCompanyName(_companyNameController.text);
    user.setLocation(_adresseController.text);
    user.setCompanySize(_sizeList[_selectedHeight]["id"]);
    user.setSecteurActivite(_sectorList[_selectedSector]["id"]);
    logger.i(user.companyName);
    logger.i(user.address);
    logger.i(user.companySize);
    logger.i(user.secteurActivite);
  }

  void getHttp() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    try {
      Response companySizesResponse = await dio.get("/company_sizes");
      Response secteursActivitesResponse = await dio.get("/secteurs_activites");
      setState(() {
        _sizeList = companySizesResponse.data;
        _sectorList = secteursActivitesResponse.data;
      });
    } catch (e) {
      logger.e('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: CustomColors.white(),
      resizeToAvoidBottomInset: false,
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
                            controller: _companyNameController,
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
                                    .grey(), // Couleur du placeholder
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
                                    .grey(), // Couleur du placeholder
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
                            value: _sectorList.isNotEmpty
                                ? _sectorList[_selectedSector]["nom"]
                                : "",
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSector = _sectorList
                                    .indexWhere((e) => e["nom"] == newValue!);
                              });
                            },
                            items: _sectorList
                                .map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value["nom"],
                                child: Text(value["nom"]),
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
                                    .grey(), // Couleur du placeholder
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
                            value: _sizeList.isNotEmpty
                                ? _sizeList[_selectedHeight]["nom"]
                                : "",
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedHeight = _sizeList
                                    .indexWhere((e) => e["nom"] == newValue!);
                              });
                            },
                            items: _sizeList
                                .map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value["nom"],
                                child: Text(value["nom"]),
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
                  handleButtonClick(),
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
