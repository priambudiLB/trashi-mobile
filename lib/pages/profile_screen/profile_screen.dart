import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/pages/profile_screen/components/profile_background.dart';
import 'package:trashi/pages/profile_screen/components/profile_button.dart';
import 'package:trashi/pages/profile_screen/components/profile_screen_auth.dart';
import 'package:trashi/pages/profile_screen/components/profile_screen_authed_header.dart';
import 'package:trashi/pages/profile_screen/components/profile_screen_menu.dart';
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
              child: Column(
                children: [
                  ProfileScreenMenu(
                    icon: "assets/images/ic-name.svg",
                    text: "Your Profile",
                    onTap: () {
                      print("Your Profile");
                    },
                  ),
                  ProfileScreenMenu(
                    icon: "assets/images/ic-notification.svg",
                    text: "Notification",
                    onTap: () {
                      print("Notification");
                    },
                  ),
                  ProfileScreenMenu(
                    icon: "assets/images/ic-padlock.svg",
                    text: "Privacy",
                    onTap: () {
                      print("Privacy");
                    },
                  ),
                  ProfileScreenMenu(
                    icon: "assets/images/ic-information.svg",
                    text: "Daftar Harga Pengangkatan",
                    onTap: () {
                      print("Daftar Harga Pengangkatan");
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        ProfileButton(
                          text: "Pembayaran Retribusi",
                          onTap: () {
                            print("Pembayaran Retribusi");
                          },
                        ),
                        Container(
                          height: 16,
                        ),
                        ProfileButton(
                          text: "Request Pengangkatan",
                          onTap: () {
                            print("Request Pengangkatan");
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
    );
  }
}