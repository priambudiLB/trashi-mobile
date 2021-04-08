import 'package:flutter/material.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication.dart';
import 'package:trashi/pages/profile_screen/components/social_media_button.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class ProfileScreenAuth extends StatelessWidget {
  const ProfileScreenAuth({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        context.watch<Authentication>().isLogin ? "or log in with" : "or sign up with",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SocialMediaButton(
                              logo: "assets/images/ic-facebook.png",
                              color: "#2B5C93",
                              text: "facebook",
                              onTap: () {
                                print('facebook');
                              },
                            ),
                            SocialMediaButton(
                              logo: "assets/images/ic-google.png",
                              color: "#ED3739",
                              text: "Google",
                              onTap: () {
                                print('Google');
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          ],
        )
    );
  }
}