import 'package:flutter/cupertino.dart';

class BeratBarang {
  final String name;

  const BeratBarang({@required this.name});

  factory BeratBarang.fromJson(Map<String, dynamic> object) {
    return BeratBarang(name: object["name"]);
  }
}
