import 'package:flutter/material.dart';
import 'package:memory_project/Screens/Login/components/background.dart';
import 'package:memory_project/Screens/Signup/signup_screen.dart';
import 'package:memory_project/Screens/password_forgot/password_forgot_screen.dart';
import 'package:memory_project/components/already_have_an_account_acheck.dart';
import 'package:memory_project/components/flat_button.dart';
import 'package:memory_project/components/rounded_button.dart';
import 'package:memory_project/components/rounded_input_field.dart';
import 'package:memory_project/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Connexion",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.05),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),

            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            FlatButtonFunction(
                text: Text("Mot de passe oublié", style: TextStyle(fontSize: size.height * 0.02),),
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          PasswordForgotScreen()
                      )
                  );
                }),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Se connecter",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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
