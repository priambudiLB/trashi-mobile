import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String PATH = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBarEmpty(),
        body: ListView(
          children: <Widget>[
            Text("Home")
          ],
        ),
    );
  }
}