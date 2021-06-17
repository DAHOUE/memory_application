import 'package:flutter/material.dart';

class Appareil {

  final String numero_appareil;
  final String nom_appareil;
  final String localisation_appareil;
  final String etat_appareil;


  Appareil({this.numero_appareil, this.nom_appareil, this.localisation_appareil, this.etat_appareil});

  factory Appareil.fromJson(Map<String, dynamic> json) {
    return Appareil(
        numero_appareil: json['numero_appareil'].toString(),
        nom_appareil: json['nom_appareil'].toString(),
        localisation_appareil: json['localisation_appareil'].toString(),
        etat_appareil: json['etat_appareil'].toString()
    );
  }
}