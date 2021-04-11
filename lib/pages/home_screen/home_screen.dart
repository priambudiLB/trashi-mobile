import 'package:flutter/material.dart';
import 'package:trashi/pages/home_screen/components/news_card_container.dart';
import 'package:trashi/pages/home_screen/components/news_search_bar.dart';
import 'package:trashi/pages/pool_detail_screen/pool_detail_screen.dart';
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

          // will be removed later yak
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PoolDetailScreen(
                        poolNumber: 20,
                        region: "Cipinang Elok, Jakarta Timur"))),
            child: Text("to news card"),
          )
        ],
      ),
      backgroundColor: hexToColor(MAIN_COLOR),
    );
  }
}
