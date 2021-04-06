import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/profile-background.svg",
          semanticsLabel: "profile background",
        ),
        Positioned(
          right: 10,
          top: 47,
          child: SvgPicture.asset(
            "assets/images/recycle.svg",
            semanticsLabel: "recycle",
            width: 150,
          ),
        )
      ],
    );
  }
}
