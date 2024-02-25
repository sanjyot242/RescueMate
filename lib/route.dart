import 'package:flutter/material.dart';
import 'package:rescuemate/screens/main_screen.dart';
import 'package:rescuemate/screens/splash_screen.dart';
import 'package:rescuemate/screens/sos_info_screen.dart';

const String splashScreen = 'splash_screen';
const String mainScreen = 'main_screen';
const String sosInfoScreen = 'sos_info_screen';

Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case mainScreen:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case sosInfoScreen:
      return MaterialPageRoute(builder: (context) => SosInfoScreen());
    default:
      throw ('No such route exists');
  }
}