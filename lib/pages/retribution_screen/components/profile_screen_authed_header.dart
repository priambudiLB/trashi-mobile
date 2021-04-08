import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class ProfileScreenAuthedHeader extends StatelessWidget {
  const ProfileScreenAuthedHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            30, 70, 30, 0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Cacaco,",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: hexToColor('#FBD1A2'),
                fontSize: 20,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
            ),
            Text(
              "Welcome to TrasHI",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 25,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}