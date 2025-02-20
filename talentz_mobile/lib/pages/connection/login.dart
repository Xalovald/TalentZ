import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/pages/connection/signup.dart';
import 'package:talentz/pages/main_pages/main_page.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final Logger logger = Logger();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPwd = false;
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://57.129.129.23:5212/api",
      connectTimeout: const Duration(seconds: 90000),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  void handleButtonClick() async {
    try {
      Map<String, String> data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      Response response = await dio.post("/users/login", data: data, options: Options(contentType: "application/json"));
      if(response.statusCode == 200) {
        await CustomHelpers.saveCurrentId(response.data["id"]);
        Response responseUser = await dio.get("/users/${response.data["id"]}", options: Options(contentType: "application/json"));
        if(!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(responseUser.data["role"])));
      }
      else {
        logger.e(response.data);
      }
    } catch (e) {
      logger.e('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: CustomColors.lightPink(),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(50, 150)),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: CustomColors.lightYellow(),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(50, 150)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 90.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.lightPink(),
                            CustomColors.pink()
                          ],
                        ),
                        border: Border.all(
                            color: CustomColors.lightPink(), width: 10),
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.black(opacity: 0.5),
                            offset: const Offset(0, 3),
                            spreadRadius: 0.5,
                            blurStyle: BlurStyle.normal,
                            blurRadius: 0.5,
                          )
                        ]),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Center(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: CustomImages.bombCherry(
                                width: constraints.maxWidth * 0.7,
                                height: constraints.maxWidth * 0.7,
                                fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.lightYellow(),
                            CustomColors.yellow()
                          ],
                        ),
                        border: Border.all(
                            color: CustomColors.lightYellow(), width: 10),
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.black(opacity: 0.5),
                            offset: const Offset(0, 3),
                            spreadRadius: 0.5,
                            blurStyle: BlurStyle.normal,
                            blurRadius: 0.5,
                          )
                        ]),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Center(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: CustomImages.cherry(6,
                                width: constraints.maxWidth * 0.7,
                                height: constraints.maxWidth * 0.7),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Align(
                alignment: Alignment.center,
                child: CustomImages.iphone14(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: PillContent(
                            width: 122,
                            height: 31,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check, size: 18),
                                Text("Compétences"),
                              ],
                            ),
                          ),
                        ),
                        PillContent(
                          width: 122,
                          height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, size: 18),
                              Text("Personnalité"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                      color: CustomColors.white(),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Connectez-vous",
                              style: CustomTextStyles.title(
                                color: CustomColors.black(),
                                size: "smaller",
                              ),
                            ),
                            Text(
                              "Entrez votre email et mot de passe pour continuer",
                              style: CustomTextStyles.text(
                                color: CustomColors.grey(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPwd = !showPwd;
                                      });
                                    },
                                    child: Icon(
                                      showPwd ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: CustomColors.lightGrey2(),
                                    )
                                  ),
                                ),
                                obscureText: showPwd ? false : true,
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                onClick: handleButtonClick,
                                width: 150,
                                heroTag: "loginBtn",
                                decoration: BoxDecoration(
                                    color: CustomColors.black(),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "Se connecter",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.white(),
                                    bold: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignupPage(noAnim: true),
                                      ),
                                  )},
                                  child: Text(
                                    "Pas encore de compte? Inscrivez-vous!",
                                    style: CustomTextStyles.text(
                                      color: CustomColors.black(),
                                      underline: true,
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
