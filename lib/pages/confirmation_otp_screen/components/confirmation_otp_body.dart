import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
part 'otp_input.dart';

class ConfirmationOTPBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Enter your\nverification code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: hexToColor("#4D4D4D")),
            ),
            Text(
              "We sent a verification code to\n" + context.watch<OTP>().account,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: hexToColor("#909090")),
            ),
            Container(
              height: 48,
            ),
            OTPInput(),
            Container(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Button(
                onTap: () {
                  context.read<OTP>().verify();
                },
                title: "Verify",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 24,
            ),
            new GestureDetector(
              onTap: () {
                context.read<OTP>().sendVerificationCode();
              },
              child: new Text(
                "Send the code again",
                style: TextStyle(fontSize: 14, color: hexToColor(MAIN_COLOR)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
