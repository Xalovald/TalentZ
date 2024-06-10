import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/pages/login_view.dart';
import 'package:talentz_mobile/widgets/button.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [CustomColors.pink, CustomColors.orange, CustomColors.red])),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(150, 27))
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.vertical(top: Radius.elliptical(150, 30))
                  ),
                  height: MediaQuery.of(context).size.height * 0.59,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bienvenue sur TalentZ",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                      const Text(
                        "Trouvez votre cerise sur le gâteau",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size.fromHeight(160),
                      ),
                      CustomButton(
                        onClick: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginView()))
                        },
                        isIcon: false,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          gradient: const LinearGradient(
                            colors: [CustomColors.orange, CustomColors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                          ),
                          border: Border.all(
                            width: 3
                          )
                        ),
                        text: "Se connecter",
                        heroTag: "connexionButton",
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                      ),
                      SizedBox.fromSize(
                        size: const Size.fromHeight(40),
                      ),
                      CustomButton(
                        onClick: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginView()))
                        },
                        isIcon: false,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          color: CustomColors.lightPink,
                          border: Border.all(
                            width: 3
                          )
                        ),
                        text: "S'inscrire",
                        heroTag: "inscriptionButton",
                        color: CustomColors.red,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
