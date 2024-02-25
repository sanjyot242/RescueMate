import 'package:flutter/material.dart';
import 'package:rescuemate/route.dart' as route;
import 'package:rescuemate/screens/sos_info_screen.dart';
import 'package:rescuemate/shared-preferences.dart';


import 'package:rescuemate/screens/splash_screen.dart';Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Lato'),
        restorationScopeId: "root",
        onGenerateRoute: route.controller,
        home: SosInfoScreen());
  }
}