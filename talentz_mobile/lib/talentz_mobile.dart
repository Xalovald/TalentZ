import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/pages/connection/signup.dart';
//import 'package:talentz/test.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talentz Mobile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.red(),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.ltr,
        child: SignupPage(),
        //child: TestPage(),
      ),
    );
  }
}