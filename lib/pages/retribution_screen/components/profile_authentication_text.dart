import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class ProfileAuthenticationText extends StatefulWidget {
  final String type;

  const ProfileAuthenticationText({Key key, this.type}) : super(key: key);
  @override
  _ProfileAuthenticationText createState() => _ProfileAuthenticationText();
}

class _ProfileAuthenticationText extends State<ProfileAuthenticationText> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyleInactive = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      color: hexToColor("#D0D0D0"),
      fontSize: 22,
    );
    TextStyle textStyleActive = TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 22,
    );
    String text = "";
    TextStyle textStyle = TextStyle();

    if (widget.type == "login") {
      text = "Login";
      if (context.watch<Authentication>().isLogin) {
        textStyle = textStyleActive;
      } else {
        textStyle = textStyleInactive;
      }
    } else {
      text = "Signup";
      if (!context.watch<Authentication>().isLogin) {
        textStyle = textStyleActive;
      } else {
        textStyle = textStyleInactive;
      }
    }

    return Container(
      decoration: textStyle == textStyleActive ? BoxDecoration(
          border: Border(bottom: BorderSide(
            color: hexToColor("#15C711"),
            width: 1.0, // Underline thickness
          ))
      ) : null,
      child: GestureDetector(
        onTap: () {
          widget.type == "login" ? context.read<Authentication>().setLogin() : context.read<Authentication>().setRegister();
        },
        child: Text(
            text,
            style: textStyle
        ),
      )
    );
  }
}
