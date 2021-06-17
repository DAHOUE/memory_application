import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memory_project/Screens/ListDevice/list_devices.dart';
import 'package:memory_project/Screens/Login/components/background.dart';
import 'package:memory_project/Screens/Signup/signup_screen.dart';
import 'package:memory_project/Screens/bluetooth/bluetooth_app.dart';
import 'package:memory_project/Screens/password_forgot/password_forgot_screen.dart';
import 'package:memory_project/Services/api.dart';
import 'package:memory_project/components/already_have_an_account_acheck.dart';
import 'package:memory_project/components/flat_button.dart';
import 'package:memory_project/components/rounded_button.dart';
import 'package:memory_project/components/rounded_input_field.dart';
import 'package:memory_project/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var token;
  bool _passwordVisible;


  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
    email = '';
    password = '';

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        key: _scaffoldKey,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                /*RoundedInputField(
                  hintText: "Email",
                  onChanged: (emailValue) {
                    setState(() {
                      email = emailValue;
                    });
                  },
                  validator: (emailValue) {
                    if (emailValue.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),*/

                /*RoundedPasswordField(
                  onChanged: (passwordValue) {
                    setState(() {
                      password = passwordValue;
                    });
                  },
                  validator: (passwordValue) {
                    if (passwordValue.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),*/
                new TextFormField(
                  //controller: pswController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 5.0),
                      child: new Icon(Icons.email),
                    ),
                    labelText: 'Email',
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val)) {
                      return null;
                    } else
                      return "Entrer une adresse valide";
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),

                SizedBox(height: 10.0,),
                new TextFormField(
                  //controller: pswController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 5.0),
                      child: new Icon(Icons.vpn_key),
                    ),
                    labelText: 'Mot de passe',
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        //color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Entrez un mot de passe";
                    } else if (val.length < 6) {
                      return  "Entrer au moins 6 caractéres";
                    } else
                      return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
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
                  text: _isLoading? 'Proccessing...' : "Se connecter",
                  press: () {
                    if (_formKey.currentState.validate()) {

                      userLogin();
                    }
                  }
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
        ),
      ),
    );
  }

  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ListDevices(),
        ),
      );
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });

  }

  Future userLogin() async {
    // SERVER LOGIN API URL
    var url = 'http://192.168.8.100:8000/api/login';

    _setHeaders() => {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };

    // Store all data with Param Name.
    //var data = {'phone': phone, 'password': password};
    var map = Map<String, dynamic>();

    map['email'] = email;
    map['password'] = password;

    // Starting Web API Call.
    //var response = await http.post(url, body: json.encode(map));
    var response = await http.post(Uri.parse(url), body: json.encode(map), headers: _setHeaders());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);
    // If the Response Message is Matched.
    if (message['success']) {
      // Navigate to Home.
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => ListDevices()));
    } else {
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message['message']),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

  }

}

