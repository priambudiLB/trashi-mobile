import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/home_screen/home_screen.dart';
import 'package:trashi/pages/profile_screen_redesign/profile_screen_checker.dart';
import 'package:trashi/pages/upst_screen/upst_screen.dart';
import 'package:trashi/utils/commons.dart';

class BottomNavScreen extends StatefulWidget {
  final int navIndex;

  const BottomNavScreen({Key key, @required this.navIndex}) : super(key: key);
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = widget.navIndex;
    final List<Map<String, dynamic>> navbarItems = [
      {
        "text": "Home",
        "image-inactive": "assets/images/home-inactive.png",
        "image-active": "assets/images/home-active.png",
        "size": 15.0,
        "screen": HomeScreen()
      },
      {
        "text": "UPST",
        "image-inactive": "assets/images/upst-inactive.png",
        "image-active": "assets/images/upst-active.png",
        "size": 20.0,
        "screen": UPSTScreen()
      },
      {
        "text": "Profil",
        "image-inactive": "assets/images/profile-inactive.png",
        "image-active": "assets/images/profile-active.png",
        "size": 18.0,
        "screen": ProfileScreenChecker()
      },
    ];
    return Scaffold(
      body: navbarItems[_currentIndex]['screen'],
      // body: Text("a"),
      bottomNavigationBar: Container(
        height: 48,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: hexToColor("#E0E0E0").withOpacity(0.25),
              blurRadius: 7,
              offset: Offset(0, -10), // changes position of shadow
            ),
          ],
        ),
        child: Row(
            children: navbarItems
                .asMap()
                .map((index, item) => MapEntry(
                    index,
                    new Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (index == 2)
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  BottomNavScreen(
                                navIndex: index,
                              ),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              _currentIndex == index
                                  ? item['image-active']
                                  : item['image-inactive'],
                              width: item['size'],
                              height: item['size'],
                            ),
                            Container(width: 4),
                            Text(item['text'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: _currentIndex == index
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _currentIndex == index
                                        ? hexToColor(MAIN_COLOR)
                                        : hexToColor("#4D4D4D")))
                          ],
                        ),
                      ),
                    ))))
                .values
                .toList()),
      ),
    );
  }
}
