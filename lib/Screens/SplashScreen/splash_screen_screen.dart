import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_project/Screens/Welcome/welcome_screen.dart';
import 'package:memory_project/components/rounded_text.dart';
import 'package:memory_project/constants.dart';

class SplashScreenScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreenScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 10);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => WelcomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            TextWithStyle(text: "Welcome to COM DEVICE", fontSize: 20.0 ,
              fontWeight: FontWeight.bold, textAlign: TextAlign.center,),
            SizedBox(height: 10.0,),
            Container(
              child: Image.asset("assets/images/xdomotik-recap--reseau.jpg.pagespeed.ic.nHLO-19u5p.jpeg"),
            ),
            SizedBox(height: 10.0,),

            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                //backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                strokeWidth: 8,

              ),
            )
          ],
        ),
      ),
    );
  }

}
