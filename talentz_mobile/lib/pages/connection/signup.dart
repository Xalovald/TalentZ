import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/helpers/helpers.dart';
import 'package:talentz/pages/Onboarding/company/onboarding1.dart';
import 'package:talentz/pages/connection/login.dart';
import 'package:talentz/pages/main_pages/main_page.dart';
import 'package:talentz/pages/onboarding/candidats/onboarding1.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/button.dart';
import 'package:talentz/widgets/pill_content.dart';

class SignupPage extends StatefulWidget {
  final bool noAnim;
  const SignupPage({super.key, this.noAnim = false});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    final double screenHeight = PlatformDispatcher.instance.views.first.physicalSize.height / PlatformDispatcher.instance.views.first.devicePixelRatio;
    _checkForFile();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: widget.noAnim ? 0 : screenHeight * 0.45, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    // Pour changer le temps d'attente avant l'animation
    Timer(const Duration(milliseconds: 1500), controller.forward);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkForFile() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://57.129.129.23:5212/api",
        connectTimeout: const Duration(seconds: 90000),
      ),
    );
    if(await CustomHelpers.getCurrentId() != null) {
      var response = await dio.get("/users/${await CustomHelpers.getCurrentId()}");
      if(!mounted) return;
      if(response.data == "") {
        CustomHelpers.deleteFile();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogInPage()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(response.data["role"])));
      }
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
                            child: CustomImages.cherry(
                                6,
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
                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, animation.value),
                      child: child,
                    );
                  },
                  child: Container(
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
                                "Votre recherche commence ici,\nsaisissez l'opportunité",
                                style: CustomTextStyles.title(
                                  color: CustomColors.black(),
                                  size: "smaller",
                                ),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur\nadipliscing elit Lorem ipsum dolor sit amet,\nconsectetur adipliscing elit",
                                style: CustomTextStyles.text(
                                  color: CustomColors.grey(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onClick: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        const Onboarding1Candidats(),
                                    ),
                                  ),
                                },
                                width: 150,
                                heroTag: "candidateSplashBtn",
                                decoration: BoxDecoration(
                                    color: CustomColors.lightGrey3(),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "Je suis candidat",
                                  style: CustomTextStyles.text(
                                    color: CustomColors.black(),
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
                                        builder: (context) =>
                                            const Onboarding1Company(),
                                      ),
                                    ),
                                  },
                                  width: 150,
                                  heroTag: "companySplashBtn",
                                  decoration: BoxDecoration(
                                      color: CustomColors.black(),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    "Je suis recruteur",
                                    style: CustomTextStyles.text(
                                      color: CustomColors.white(),
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LogInPage(),
                                      ),
                                  )},
                                  child: Text(
                                    "Vous avez déjà un compte? Connectez-vous!",
                                    style: CustomTextStyles.text(
                                      color: CustomColors.black(),
                                      underline: true,
                                    ),
                                  ),
                                )
                              )
                            ],
                          )
                        ],
                      ),
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
