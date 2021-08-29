import 'package:flutter/cupertino.dart';

class Barang {
  final String name;

  const Barang({@required this.name});

  factory Barang.fromJson(Map<String, dynamic> object) {
    return Barang(name: object["name"]);
  }
}
