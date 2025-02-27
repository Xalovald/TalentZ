import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/icons/icons.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/models/user.dart';
import 'package:talentz/pages/connection/login.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final Logger logger = Logger();
  late User user;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();

    getHttp();
  }

  void getHttp() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    try {
      Response response =
          await dio.get("/users/${await CustomHelpers.getCurrentId()}");
      setState(() {
        data = response.data;
      });
    } catch (e) {
      logger.e('$e');
    }
  }

  void handleButtonClick() async {
    await CustomHelpers.deleteFile();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogInPage()));
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return data != null
        ? Scaffold(
            backgroundColor: CustomColors.white(),
            appBar: AppBar(
              backgroundColor: CustomColors.white(),
              surfaceTintColor: CustomColors.white(),
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: CustomColors.lightGrey2())),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 74,
                                  width: 74,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: CustomColors.slateWhite(),
                                        width: 5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5, // Ombre vers le haut
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: data!["cerise"] != null
                                          ? [
                                              CustomColors.lightBlue(),
                                              CustomColors.lighterBlue(),
                                            ]
                                          : [
                                              CustomColors.white(),
                                              CustomColors.white()
                                            ],
                                    ),
                                  ),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return Center(
                                      child: data!["cerise"] != null
                                          ? CustomImages.cherry(
                                              data!["cerise"]["id"],
                                              width: constraints.maxWidth * 0.7,
                                              height:
                                                  constraints.maxWidth * 0.7,
                                              fit: BoxFit.contain)
                                          : const SizedBox(),
                                    );
                                  }),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data!["role"] == "candidat"
                                          ? data!["firstName"] +
                                              " " +
                                              data!["lastName"]
                                          : data!["companyName"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.black(),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Couturière",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.grey(),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          CustomButton(
                            heroTag: "profilPageEditNameTopBtn",
                            onClick: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: CustomColors.lightGrey7(),
                            ),
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.edit_outlined),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                      color: CustomColors.grey(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.48,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildSectionButton(
                              'Informations personnelles', Icons.person_outline,
                              text: "Mon compte"),
                          _buildSectionButton(
                              'Gérer ma recherche', CustomIcons.cupcake,
                              text: "Mon activité"),
                          _buildSectionButton(
                              'Mes badges', Icons.circle_outlined,
                              showText: false),
                          _buildSectionButton('FAQ', Icons.chat_bubble_outline,
                              text: "Support"),
                          _buildSectionButton(
                              'Nous contacter', Icons.email_outlined,
                              showText: false),
                          _buildSectionButton(
                              'Avantages', Icons.error_outline_rounded,
                              showText: false),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onClick: handleButtonClick,
                    width: 150,
                    heroTag: "profilPageLogoutBtn",
                    decoration: BoxDecoration(
                        color: CustomColors.black(),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "Déconnexion",
                      style: CustomTextStyles.text(
                        color: CustomColors.white(),
                        bold: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildSectionButton(String title, IconData trailingIcon,
      {String? text, bool showText = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showText
              ? Text(
                  text!,
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColors.black(),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                  ),
                )
              : const SizedBox(),
          SizedBox(height: showText ? 8 : 0),
          Card(
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(
                    bottom: trailingIcon == CustomIcons.cupcake ? 22 : 0,
                    top: trailingIcon == CustomIcons.cupcake ? 0 : 3),
                child: Icon(
                  trailingIcon,
                  color: CustomColors.black(),
                  size: trailingIcon == CustomIcons.cupcake ? 1.4 : 24,
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: CustomColors.black(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CustomColors.black(),
                size: 18,
              ),
              onTap: () {},
              shape: Border(
                bottom: BorderSide(color: CustomColors.lightGrey2()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
