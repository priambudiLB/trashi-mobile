import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String PATH = "profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBarEmpty(),
        body: ListView(
          children: <Widget>[
            Text("Profile")
          ],
        ),
    );
  }
}