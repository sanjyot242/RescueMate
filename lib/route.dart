import 'package:flutter/material.dart';
import 'package:rescuemate/screens/main_screen.dart';
import 'package:rescuemate/screens/splash_screen.dart';
import 'package:rescuemate/screens/sos_info_screen.dart';
import 'package:rescuemate/screens/edit_sos_info_screen.dart';
import 'package:rescuemate/screens/view_dispensary_screen.dart';
import 'package:rescuemate/screens/view_hospital_screen.dart';

const String splashScreen = 'splash_screen';
const String mainScreen = 'main_screen';
const String sosInfoScreen = 'sos_info_screen';
const String editSosInfoScreen = 'edit_sos_info_screen';
const String viewHospitalScreen = 'view_hospital_screen';
const String viewDispensaryScreen = 'view_dispensary_screen';

Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case mainScreen:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case sosInfoScreen:
      return MaterialPageRoute(builder: (context) => SosInfoScreen());
    case editSosInfoScreen:
      return MaterialPageRoute(builder: (context) => EditSosInfoScreen());
    case viewHospitalScreen:
      return MaterialPageRoute(builder: (context) => ViewHospitalScreen());
    case viewDispensaryScreen:
      return MaterialPageRoute(builder: (context) => ViewDispensaryScreen());
    default:
      throw ('No such route exists');
  }
}