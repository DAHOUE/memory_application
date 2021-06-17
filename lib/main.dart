import 'package:flutter/material.dart';
import 'package:memory_project/Screens/ListDevice/list_devices.dart';
import 'package:memory_project/Screens/Welcome/welcome_screen.dart';
import 'package:memory_project/constants.dart';

import 'Screens/SplashScreen/splash_screen_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Command device',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
