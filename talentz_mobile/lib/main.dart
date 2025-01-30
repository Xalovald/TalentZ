import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talentz_mobile/models/user.dart';
import 'package:talentz_mobile/talentz_mobile.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => User(),
      child: const MyApp(),
    ),
  );
}