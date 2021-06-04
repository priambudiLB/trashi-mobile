import 'package:flutter/cupertino.dart';

class Kendaraan {
  final String name;

  const Kendaraan({@required this.name});

  factory Kendaraan.fromJson(Map<String, dynamic> object) {
    return Kendaraan(name: object["name"]);
  }
}
