import 'package:flutter/material.dart';
import 'package:memory_project/Screens/Login/login_screen.dart';
import 'package:memory_project/Screens/Signup/components/background.dart';
import 'package:memory_project/Screens/Signup/components/or_divider.dart';
import 'package:memory_project/Screens/Signup/components/social_icon.dart';
import 'package:memory_project/Screens/bluetooth/bluetooth_app.dart';
import 'package:memory_project/components/already_have_an_account_acheck.dart';
import 'package:memory_project/components/rounded_button.dart';
import 'package:memory_project/components/rounded_input_field.dart';
import 'package:memory_project/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String password2;
  bool _passwordVisible;
  bool _passwordVisible2;
  var token;


  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;

    email = '';
    password = '';
    name = '';
    password2 = '';
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Inscription",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height * 0.05),
                ),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
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
                    labelText: 'Nom',
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isNotEmpty) {
                      return null;
                    } else
                      return "Entrer une adresse valide";
                  },
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                        borderRadius: BorderRadius.circular(20.0)),
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
                SizedBox(
                  height: 10.0,
                ),
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
                        borderRadius: BorderRadius.circular(20.0)),
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
                SizedBox(
                  height: 10.0,
                ),
                new TextFormField(
                  //controller: pswController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: !_passwordVisible2,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 5.0),
                        child: new Icon(Icons.vpn_key)
                    ),
                    labelText: 'Confirmer mot de passe',
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        //color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Entrez un mot de passe";
                    } else if (val.length < 6) {
                      return "Entrer au moins 6 caractéres";
                    } else
                      return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      password2 = val;
                    });
                  },
                ),
                RoundedButton(
                  text: "S'inscrire",
                  press: () {

                    if (_formKey.currentState.validate()) {
                      if (password == password2) {
                       /* userRegistration();*/
                        LoginScreen();
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                contentPadding: EdgeInsets.all(20.0),
                                children: [
                                  Text(
                                      'Les deux mots de passe sont non conforme')
                                ],
                              );
                            });
                      }
                    } else {
                      print('Error');
                    }

                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
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
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future userRegistration() async {
    // SERVER API URL
    var url = 'http://192.168.8.100:8000/api/register';

    // Store all data with Param Name.

    var map = Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;

    var response = await http.post(Uri.parse(url), body: json.encode(map), headers: _setHeaders());

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    //if (response.statusCode == 200) {}

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message['message']),
          actions: <Widget>[
            message['success']
                ? FlatButton(
              child: new Text("Se connecter"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Bluetooth()));
              },
            )
                : FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            )
          ],
        );
      },
    );
  }
}

