import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:talentz_mobile/talentz_mobile.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
