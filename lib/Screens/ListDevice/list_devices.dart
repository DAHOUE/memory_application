import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_project/components/rounded_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:memory_project/Models/Appareil.dart';



class ListDevices extends StatefulWidget {
  const ListDevices({Key key}) : super(key: key);

  @override
  _ListDevicesState createState() => _ListDevicesState();
}

class _ListDevicesState extends State<ListDevices> {
 Future<List<Appareil>> futureGetData;
  List<Appareil> _postList =new List<Appareil>();

  Future<List<Appareil> > fetchPost() async {
    final response =
    await http.get(Uri.parse('http://192.168.8.100:8000/api/getAppareils'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _postList.add(Appareil.fromJson(map));

          }
        }
      }
      return _postList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  void initState() {
    super.initState();
    futureGetData = fetchPost();
    // ignore: unnecessary_statements
    this.color  = color;
  }
  var token;
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  bool color;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Liste des appareils",),
          backgroundColor: Colors.blue,
          centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: FutureBuilder(

          future: futureGetData,
          builder: (BuildContext context, AsyncSnapshot<List<Appareil>> snapshot) {
            if (snapshot.hasData)
              {

                return  ListView.builder(

                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        color = snapshot.data[index].etat_appareil == 'ON' ? true : false;
                        return Container(
                          height: MediaQuery.of(context).size.width / 2,
                          child: Card(

                            margin: EdgeInsets.all(10.0),
                            color: color == true ? Colors.green : Colors.red,
                            elevation: 10.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data[index].nom_appareil, textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textScaleFactor: 2.0,),
                                Text(snapshot.data[index].localisation_appareil, textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white), textScaleFactor: 1.5,),
                                Row(
                                  children: [
                                    SizedBox(width: 5.0),
                                    Expanded(

                                        child: ElevatedButton(
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        setState(() {
                                          color = false ;
                                        });
                                        eteindre(snapshot.data[index].numero_appareil.toString());


                                      },
                                      child: Text('OFF', textScaleFactor: 1.6,),
                                      )),
                                    SizedBox(width: 10.0),
                                    Expanded(

                                        child: ElevatedButton(
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        setState(() {
                                          color = true;
                                        });
                                        allumer(snapshot.data[index].numero_appareil.toString());


                                      },
                                      child: Text('ON', textScaleFactor: 1.6,),
                                    )),
                                    SizedBox(width: 5.0),

                                  ],
                                )
                              ],
                            )


                          ),
                        );
                      }
                  );

              } else if (snapshot.hasError) {
                    return Text("Error");
                    }
                    return SimpleDialog(
                      title: Text('Veuillez patienter...'),
                      children: [
                        Center(
                            child:CircularProgressIndicator())
                      ],
                    );
            }
          ),
      /*GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('APPAREIL N°${index+1}', textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      SizedBox(width: 5.0),
                      Expanded(

                          child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          eteindre(index+1);
                        },
                        child: Text('OFF'),
                        )),
                      SizedBox(width: 10.0),
                      Expanded(

                          child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          allumer(index+1);
                        },
                        child: Text('ON'),
                      )),
                      SizedBox(width: 5.0),

                    ],
                  )
                ],
              )


            );
          }
      ),*/

    );
  }

  Future allumer(String index) async {
    //url de l'api
    var url = 'http://192.168.8.100:8000/api/allumer';

    //l'entête de l'api
    _setHeaders() => {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var map = Map<String, dynamic>();

    map['nom_appareil'] = 'Nom Appareil';
    map['numero_appareil'] = index;
    map['localisation_appareil'] = "Localisation Appareil";

    var response = await http.post(Uri.parse(url), body: json.encode(map), headers: _setHeaders());

    var message = jsonDecode(response.body);
    
    if(message['success'])
      {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ListDevices();
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    else
      {
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
  Future eteindre(String index) async {
    //url de l'api
    var url = 'http://192.168.8.100:8000/api/eteindre';

    //l'entête de l'api
    _setHeaders() => {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var map = Map<String, dynamic>();

    map['nom_appareil'] = 'Nom Appareil';
    map['numero_appareil'] = index;
    map['localisation_appareil'] = "Localisation Appareil";

    var response = await http.post(Uri.parse(url), body: json.encode(map), headers: _setHeaders());

    var message = jsonDecode(response.body);

    if(message['success'])
    {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListDevices();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
    else
    {
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