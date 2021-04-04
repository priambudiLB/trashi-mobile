import 'package:flutter/material.dart';

class UPSTScreen extends StatefulWidget {
  static const String PATH = "home";

  @override
  _UPSTScreenState createState() => _UPSTScreenState();
}

class _UPSTScreenState extends State<UPSTScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBarEmpty(),
        body: ListView(
          children: <Widget>[
            Text("UPST")
          ],
        ),
    );
  }
}