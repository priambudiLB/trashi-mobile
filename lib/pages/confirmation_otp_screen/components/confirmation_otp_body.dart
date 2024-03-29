import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/registration_screen/provider/registration.dart';
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
                onTap: () async {
                  await context.read<OTP>().verify();

                  if (context.read<OTP>().isError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      buildErrorSnackBar(
                        message: context.read<OTP>().errorMessage,
                      ),
                    );
                  }
                },
                title: "Verify",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 24,
            ),
            new GestureDetector(
              onTap: () async {
                showTrashiProgressIndicator(context);

                await context
                    .read<RegistrationProvider>()
                    .generateVerificationCode();

                if (!context
                    .read<RegistrationProvider>()
                    .isGenerateVerificationCodeSuccessful) {
                  ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(
                    message:
                        'Terjadi kesalahan dalam me-generate verification code. Silakan coba beberapa saat lagi.',
                  ));
                }

                closeTrashiProgressIndicator(context);
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
