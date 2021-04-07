import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/pages/profile_screen/components/profile_background.dart';
import 'package:trashi/pages/profile_screen/components/profile_screen_auth.dart';
import 'package:trashi/pages/profile_screen/components/profile_screen_authed_header.dart';
import 'package:trashi/utils/commons.dart';

class ProfileScreen extends StatefulWidget {
  static const String PATH = "profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor('#EEEFEF'),
        body: ListView(
          children: <Widget>[
            Stack(
              children: [
                ProfileBackground(),
                // ProfileScreenAuth()
                ProfileScreenAuthedHeader()
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 32, 30, 10),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 0.5, // Underline thickness
                    )
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 32),
                            child: SvgPicture.asset("assets/images/form-name.svg"),
                          ),
                          Text(
                            "Your Profile",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        "assets/images/chevron-right.svg",
                        semanticsLabel: 'confirm',
                      ),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
    );
  }
}