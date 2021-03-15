import 'package:flutter/material.dart';
import 'package:memory_project/Screens/Welcome/welcome_screen.dart';
import 'package:memory_project/constants.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenScreen extends StatefulWidget {
  @override
  _SplashScreenScreenState createState() => new _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      photoSize: 120,
      seconds: 14,
      navigateAfterSeconds: new WelcomeScreen(),
      title: new Text(
        'Welcome In Command device',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset(
          'assets/images/développement-article-borne-escamotable.jpg', fit: BoxFit.cover,),
      backgroundColor: Colors.white,
      loaderColor: kPrimaryColor,
    );
  }
}