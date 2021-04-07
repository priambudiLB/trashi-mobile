import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class SocialMediaButton extends StatefulWidget {
  final String logo;
  final String color;
  final String text;
  final Function onTap;

  const SocialMediaButton({
    Key key,
    this.logo, this.color, this.text, this.onTap
  }) : super(key: key);
  @override
  _SocialMediaButton createState() => _SocialMediaButton();
}

class _SocialMediaButton extends State<SocialMediaButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 120,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: hexToColor(widget.color),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Image.asset(
                widget.logo,
                width: 20,
              ),
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
