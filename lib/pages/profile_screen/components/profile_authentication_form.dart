import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication_input.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class AuthenticationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: context.watch<Authentication>().isLogin ? AuthenticationFormLogin() : AuthenticationFormRegister()
    );
  }
}

class AuthenticationFormRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthenticationInput(
          widgetKey: "register-name",
          textInputType: TextInputType.text,
          svgImage: "assets/images/form-name.svg",
          hintText: "NAME",
          errorText: "Format nama salah",
          isValid: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Container(
          height: 8,
        ),
        AuthenticationInput(
          widgetKey: "register-email",
          textInputType: TextInputType.emailAddress,
          svgImage: "assets/images/form-email.svg",
          hintText: "EMAIL",
          errorText: "Format email salah",
          isValid: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Container(
          height: 8,
        ),
        AuthenticationInput(
          widgetKey: "register-phone",
          textInputType: TextInputType.phone,
          svgImage: "assets/images/form-phone.svg",
          hintText: "PHONE NUMBER",
          errorText: "Format telpon salah",
          isValid: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Container(
          height: 8,
        ),
        AuthenticationInput(
          widgetKey: "register-password",
          textInputType: TextInputType.visiblePassword,
          svgImage: "assets/images/form-password.svg",
          hintText: "PASSWORD",
          errorText: "Format password salah",
          isValid: true,
          isPassword: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: new TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: hexToColor('#304860')
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'By clicking next,\nyou agree to our '),
                    new TextSpan(
                        text: 'terms & condition',
                        recognizer: TapGestureRecognizer()..onTap = () {
                          // Single tapped.
                        },
                        style: new TextStyle(color: hexToColor('#ED7D32'))
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: hexToColor('#7CC599'),
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/images/chevron-right.svg",
                        semanticsLabel: 'confirm',
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class AuthenticationFormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthenticationInput(
          widgetKey: "register-email",
          textInputType: TextInputType.emailAddress,
          svgImage: "assets/images/form-email.svg",
          hintText: "EMAIL",
          errorText: "Format email salah",
          isValid: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Container(
          height: 8,
        ),
        AuthenticationInput(
          widgetKey: "register-password",
          textInputType: TextInputType.visiblePassword,
          svgImage: "assets/images/form-password.svg",
          hintText: "PASSWORD",
          errorText: "Format password salah",
          isValid: true,
          isPassword: true,
          onChanged: (text) {
            print("First text field: $text");
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'forgot your password ?',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: hexToColor('#304860')
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: hexToColor('#7CC599'),
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/images/chevron-right.svg",
                        semanticsLabel: 'confirm',
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}