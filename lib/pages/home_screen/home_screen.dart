import 'package:flutter/material.dart';
import 'package:trashi/pages/home_screen/components/news_search_bar.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/constants/colors.dart';

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
      body: ListView(
        children: <Widget>[NewsSearchBar()],
      ),
      backgroundColor: hexToColor(MAIN_COLOR),
    );
  }
}
