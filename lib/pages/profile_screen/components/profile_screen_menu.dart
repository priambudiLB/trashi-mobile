import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication.dart';
import 'package:trashi/pages/profile_screen/components/social_media_button.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class ProfileScreenMenu extends StatefulWidget {
  final String icon;
  final String text;
  final Function onTap;

  const ProfileScreenMenu({
    Key key,
    this.icon, this.text, this.onTap
  }) : super(key: key);
  @override
  _ProfileScreenMenu createState() => _ProfileScreenMenu();
}

class _ProfileScreenMenu extends State<ProfileScreenMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                      width: 32,
                      margin: EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(widget.icon),
                    ),
                    Text(
                      widget.text,
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
    );
  }
}