import 'package:flutter/material.dart';
import 'package:trashi/pages/home_screen/components/news_card_container.dart';
import 'package:trashi/pages/home_screen/components/news_search_bar.dart';
import 'package:trashi/pages/home_screen/components/news_card.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String PATH = "home";
  final String latestNewsText = "Latest News";
  final double latestNewsFontSize = 20;
  final double paddingTextBottom = 8;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          NewsSearchBar(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: widget.paddingTextBottom),
          ),
          Text(
            widget.latestNewsText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w800,
              fontSize: widget.latestNewsFontSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.paddingTextBottom),
          ),
          NewsCardContainer(),
        ],
      ),
      backgroundColor: hexToColor(MAIN_COLOR),
    );
  }
}
