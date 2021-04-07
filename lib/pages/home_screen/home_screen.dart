import 'package:flutter/material.dart';
import 'package:trashi/pages/home_screen/components/news_search_bar.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String PATH = "home";
  final String latestNewsText = "Latest News";
  final double latestNewsFontSize = 30;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          NewsSearchBar(),
          Text(
            widget.latestNewsText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w800,
              fontSize: widget.latestNewsFontSize,
            ),
          )
        ],
      ),
      backgroundColor: hexToColor(MAIN_COLOR),
    );
  }
}
