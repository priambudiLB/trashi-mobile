import 'package:flutter/material.dart';
import 'package:trashi/components/layout.dart';
import 'package:trashi/pages/retribution_screen/components/calendar_popup.dart';
import 'package:trashi/pages/retribution_screen/components/past_payment.dart';
import 'package:trashi/pages/retribution_screen/components/waiting_for_payment.dart';
import 'package:trashi/utils/commons.dart';

class RetributionScreen extends StatefulWidget {
  static const String PATH = "retribution";

  @override
  _RetributionScreenState createState() => _RetributionScreenState();
}

class _RetributionScreenState extends State<RetributionScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        height: 88,
        title: Text(
          "Pembayaran\nRetribusi",
          textAlign: TextAlign.end,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: hexToColor('#FBD1A2'),
            fontSize: 24,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                WaitingForPayment(),
                PastPayment(),
              ],
            ),
            CalendarPopup()
          ],
        )
    );
  }
}