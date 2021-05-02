import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/registration_screen/account_type_selection_screen.dart';
import 'package:trashi/utils/commons.dart';

class OnBoardingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    onGetStartedPressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AccountTypeSelectionScreen()));
    }

    onLoginButtonPressed() {
      print("login");
    }

    var heightTmp = 48.0;
    var widthTmp = 200.0;

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Container(height: 32),
            Text(
              "TrasHI",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  color: hexToColor(MAIN_COLOR),
                  fontSize: 20),
            ),
            Container(height: 96),
            Image.asset("assets/images/logo_truck.png"),
            Container(
              height: 24,
            ),
            Text(
              "Welcome to\nTrasHI!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: hexToColor("#4D4D4D")),
            ),
            Container(
              height: 12,
            ),
            Text(
              "Please sign up to continue",
              style: TextStyle(fontSize: 14, color: hexToColor("#909090")),
            ),
            Container(
              height: 40,
            ),
            Button(
              height: heightTmp,
              width: widthTmp,
              onTap: onGetStartedPressed,
              title: "Get Started",
              fontWeight: FontWeight.w900,
              listTextSpan: [
                TextSpan(
                  text: " ➔",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ],
            ),
            Container(
              height: 16,
            ),
            Button(
              onTap: onLoginButtonPressed,
              title: "Login",
              fontWeight: FontWeight.w800,
              fontColor: hexToColor(MAIN_COLOR),
              backgroundColor: Colors.white,
              borderColor: hexToColor(MAIN_COLOR),
            )
          ],
        ),
      ),
    );
  }
}
