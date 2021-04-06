import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication.dart';
import 'package:trashi/pages/profile_screen/components/profile_background.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      30, 70, 30, 0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to TrasHI",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 25,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 4.0),
                              blurRadius: 4.0,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        context.watch<Authentication>().isLogin ? "Please log in to continue" : "Please sign up to continue",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: hexToColor('#304860'),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ProfileAuthentication()
                      ),
                    ],
                  )
                ),
              ],
            )
          ],
        ),
    );
  }
}