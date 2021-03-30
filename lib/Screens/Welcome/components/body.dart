import 'package:flutter/material.dart';
import 'package:memory_project/Screens/Login/login_screen.dart';
import 'package:memory_project/Screens/Signup/signup_screen.dart';
import 'package:memory_project/Screens/Welcome/components/background.dart';
import 'package:memory_project/components/rounded_button.dart';
import 'package:memory_project/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_project/components/rounded_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              "WELCOME TO COM DEV",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            TextWithStyle(text: "Welcome to COM DEVICE", fontSize: size.height * 0.03 ,
            fontWeight: FontWeight.bold, textAlign: TextAlign.center,),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Se connecter",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "S'inscrire",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
