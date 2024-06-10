import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/assets/icons/icons.dart';
import 'package:talentz_mobile/pages/main_view.dart';
import 'package:talentz_mobile/widgets/button.dart';
import 'package:talentz_mobile/widgets/fab_icon.dart';
import 'package:talentz_mobile/widgets/input.dart';
import 'package:talentz_mobile/widgets/right_shadow_painter.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            CustomColors.pink,
            CustomColors.orange,
            CustomColors.red
          ])),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: Spacer()),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(150, 30))),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox.fromSize(
                        size: const Size.fromHeight(60),
                      ),
                      const Text(
                        "Connexion",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            onClick: () => {},
                            isIcon: true,
                            heroTag: "googleLogin",
                            color: Colors.white,
                            icon: const CustomFabIcon(
                              imagePath: CustomIcons.google,
                              size: 24
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all()
                            ),
                            width: 40,
                            height: 40,
                            shadowPainter: RightShadowPainter(
                              2,
                              radiusValue: 100
                            ),
                          ),
                          CustomButton(
                            onClick: () => {},
                            isIcon: true,
                            heroTag: "appleLogin",
                            color: Colors.white,
                            icon: const CustomFabIcon(
                              iconData: Icons.apple,
                              size: 30
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all()
                            ),
                            width: 40,
                            height: 40,
                            shadowPainter: RightShadowPainter(
                              2.5,
                              radiusValue: 100
                            ),
                          )
                        ],
                      ),
                      SizedBox.fromSize(size: const Size.fromHeight(20),),
                      CustomInput(
                        controller: emailController,
                        placeholder: "Email",
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 65,
                        textInputType: TextInputType.emailAddress,
                        shadowPainter: RightShadowPainter(
                          5,
                          color: Colors.black.withOpacity(0.4),
                          radiusValue: 5,
                        ),
                      ),
                      SizedBox.fromSize(size: const Size.fromHeight(20),),
                      CustomInput(
                        controller: passwordController,
                        placeholder: "Mot de passe",
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 65,
                        obscureText: true,
                        shadowPainter: RightShadowPainter(
                          5,
                          color: Colors.black.withOpacity(0.4),
                          radiusValue: 5,
                        ),
                      ),
                      SizedBox.fromSize(size: const Size.fromHeight(20),),
                      CustomButton(
                        onClick: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainView()))
                        },
                        isIcon: false,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            gradient: const LinearGradient(
                                colors: [CustomColors.orange, CustomColors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            border: Border.all(width: 3)),
                        text: "Suivant",
                        heroTag: "nextLoginButton",
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        shadowPainter: RightShadowPainter(5, color: Colors.black.withOpacity(0.4), radiusValue: 100),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
