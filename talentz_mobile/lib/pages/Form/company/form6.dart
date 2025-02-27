import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/Form/company/form8.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/choice_button_column.dart';
import 'package:talentz/widgets/progress_bar.dart';
import 'package:talentz/widgets/state_button.dart';

class Form6Company extends StatefulWidget {
  const Form6Company({super.key});
  @override
  State<Form6Company> createState() => _Form6CompanyState();
}

class _Form6CompanyState extends State<Form6Company> {
  final TextEditingController _apprentissageController =
      TextEditingController();
  final TextEditingController _valeursEthiqueController =
      TextEditingController();
  final TextEditingController _carriereController = TextEditingController();
  final TextEditingController _avantagesController = TextEditingController();
  final Logger logger = Logger();
  late User user;
  late List<dynamic> dataListApprentissages = [];
  late List<dynamic> dataListValeursEthiques = [];
  late List<dynamic> dataListCarrieres = [];
  late List<dynamic> dataListAvantages = [];

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  final List<Map<String, dynamic>> _selectedChoices = [
    {
      "type": "apprentissage",
      "choices": [],
      "title": "Que souhaites-tu apprendre ?"
    },
    {
      "type": "valeurs",
      "choices": [],
      "title": "Quelles valeurs ou éthique comptent ?"
    },
    {
      "type": "carrière",
      "choices": [],
      "title": "Quelles sont tes perspectives de carrière ?"
    },
    {
      "type": "avantages",
      "choices": [],
      "title": "Quelles avantages salariauw voudrais-tu ?"
    },
  ];

  void handleButtonClick(int id, String name, String modalType) {
    dynamic currentChoices =
        _selectedChoices.where((choice) => choice['type'] == modalType).first;
    setState(() {
      if (currentChoices['choices'].contains(id)) {
        currentChoices["choices"].removeWhere((choice) => choice["id"] == id);
      } else {
        currentChoices["choices"].add({'id': id, 'text': name});
      }
    });
  }

  void _handleSubmit() {
    _selectedChoices[0]["choices"].forEach((apprentissage) => {
          if (!user.apprentissages.contains(apprentissage["id"]))
            {user.pushToApprentissages(apprentissage["id"])}
          else
            {user.removeFromApprentissages(apprentissage["id"])}
        });
    _selectedChoices[1]["choices"].forEach((valeurs) => {
          if (!user.valeursEthiques.contains(valeurs["id"]))
            {user.pushToValeursEthiques(valeurs["id"])}
          else
            {user.removeFromValeursEthiques(valeurs["id"])}
        });
    _selectedChoices[2]["choices"].forEach((carriere) => {
          if (!user.carrieres.contains(carriere["id"]))
            {user.pushToCarrieres(carriere["id"])}
          else
            {user.removeFromCarrieres(carriere["id"])}
        });
    _selectedChoices[3]["choices"].forEach((avantage) => {
          if (!user.avantages.contains(avantage["id"]))
            {user.pushToAvantages(avantage["id"])}
          else
            {user.removeFromAvantages(avantage["id"])}
        });
    logger.i(user.apprentissages);
    logger.i(user.valeursEthiques);
    logger.i(user.carrieres);
    logger.i(user.avantages);
  }

  void getHttp() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    try {
      Response responseApprentissages = await dio.get("/apprentissages");
      Response responseValeursEthiques = await dio.get("/valeurs_ethiques");
      Response responseCarrieres = await dio.get("/carrieres");
      Response responseAvantages = await dio.get("/avantages");
      setState(() {
        dataListApprentissages = responseApprentissages.data;
        dataListValeursEthiques = responseValeursEthiques.data;
        dataListCarrieres = responseCarrieres.data;
        dataListAvantages = responseAvantages.data;
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
      appBar: AppBar(
        backgroundColor: CustomColors.white(),
        surfaceTintColor: CustomColors.white(),
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: CustomProgressBar(
            width: MediaQuery.of(context).size.width,
            height: 7,
            startAt: (((MediaQuery.of(context).size.width / 9) * 6) /
                    MediaQuery.of(context).size.width) *
                100,
            color: CustomColors.lightGrey4(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Décrivez ce que votre entreprise va apporter au futur candidat.',
                  style: TextStyle(
                    color: CustomColors.black(),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
                Text(
                  "Expliquez ce que votre entreprise offre aux futurs talents.",
                  style: TextStyle(
                    color: CustomColors.grey(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSectionButton(
                        'Apprentissage',
                        _apprentissageController,
                        'Qu’allez-vous apporter au candidat ?',
                        Icons.lightbulb_outline,
                        'Qu’allez-vous pouvoir apprendre ou consolider ?',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet.',
                        dataListApprentissages),
                    _buildSectionButton(
                        'Valeurs & éthique',
                        _valeursEthiqueController,
                        'Quelle sont vos valeurs et votre étique ?',
                        Icons.favorite_border_outlined,
                        'Quelles sont vos valeurs et votre éthique ?',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet.',
                        dataListValeursEthiques),
                    _buildSectionButton(
                        'Carrière',
                        _carriereController,
                        'Quelles évolutions de carrière ?',
                        Icons.work_outline,
                        'Quelle perspective de carrière offrez-vous ?',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet.',
                        dataListCarrieres),
                    _buildSectionButton(
                        'Avantages',
                        _avantagesController,
                        'Proposez-vous des avantages ?',
                        Icons.percent,
                        'Quels avantages proposez-vous ?',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet.',
                        dataListAvantages),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  CustomButton(
                    onClick: () => {
                      _handleSubmit(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Form8Company(),
                        ),
                      ),
                    },
                    width: 150,
                    heroTag: "form6CompanyConfirmBtn",
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
                            builder: (context) => const Form8Company(),
                          ),
                        ),
                      },
                      width: 150,
                      heroTag: "form8CompanySkipBtn",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionButton(
      String title,
      TextEditingController controller,
      String text,
      IconData trailingIcon,
      String modalTitle,
      String modalSubTitle,
      List<dynamic> modalContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: _selectedChoices
                .where((elem) =>
                    elem["type"] == title.toLowerCase().split(" ").first)
                .first["choices"]
                .isEmpty,
            child: Text(
              text,
              style: TextStyle(
                color: CustomColors.grey(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
              ),
            ),
          ),
          const SizedBox(height: 8),
          _selectedChoices
                  .where((elem) =>
                      elem["type"] == title.toLowerCase().split(" ").first)
                  .first["choices"]
                  .isEmpty
              ? Card(
                  color: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: Icon(
                      trailingIcon,
                      color: CustomColors.lightGrey2(),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        color: CustomColors.grey(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColors.black(),
                      size: 18,
                    ),
                    onTap: () {
                      _showModal(context, title, controller, modalTitle,
                          modalSubTitle, modalContent);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: CustomColors.lightGrey2()),
                    ),
                  ),
                )
              : ChoiceButtonColumn(
                  choiceButtonColumnTitle: _selectedChoices
                      .where((elem) =>
                          elem["type"] == title.toLowerCase().split(" ").first)
                      .first["title"],
                  choices: _selectedChoices
                      .where((elem) =>
                          elem["type"] == title.toLowerCase().split(" ").first)
                      .first["choices"],
                  onEditClick: () => _showModal(context, title, controller,
                      modalTitle, modalSubTitle, modalContent),
                ),
        ],
      ),
    );
  }

  void _showModal(
      BuildContext context,
      String title,
      TextEditingController controller,
      String modalTitle,
      String modalSubTitle,
      List<dynamic> modalContent) {
    TextEditingController searchController = TextEditingController();
    List<dynamic> filteredContent = modalContent;
    setState(() {
      _selectedChoices
          .where((elem) => elem["type"] == title.toLowerCase().split(" ").first)
          .first["choices"] = [];
    });

    void onSearchChanged() {
      filteredContent = modalContent
          .where((item) => item["text"]
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    searchController.addListener(onSearchChanged);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  right: 16.0,
                  left: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modalTitle,
                      style: TextStyle(
                        color: CustomColors.grey(),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    Text(
                      modalSubTitle,
                      style: TextStyle(
                        color: CustomColors.lightGrey2(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Rechercher...",
                        hintStyle: TextStyle(color: CustomColors.lightGrey5()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 5,
                          alignment: WrapAlignment.start,
                          children: filteredContent
                              .map(
                                (dynamic item) => StateButton(
                                  id: item["id"],
                                  onClicked: (id) => handleButtonClick(
                                      id,
                                      item["text"],
                                      title.toLowerCase().split(" ")[0]),
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
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                      child: Center(
                        child: CustomButton(
                          onClick: () {
                            Navigator.pop(context);
                          },
                          heroTag: 'closeModal',
                          width: 180,
                          height: 52,
                          decoration: BoxDecoration(
                            color: CustomColors.black(),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Enregistrer',
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
          },
        );
      },
    );
  }
}
