import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class ProfileButton extends StatefulWidget {
  final String text;
  final Function onTap;

  const ProfileButton({
    Key key,
    this.text, this.onTap
  }) : super(key: key);
  @override
  _ProfileButton createState() => _ProfileButton();
}

class _ProfileButton extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: hexToColor('#7CC599'),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
