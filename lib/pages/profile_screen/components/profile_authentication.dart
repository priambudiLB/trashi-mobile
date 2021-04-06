import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication_form.dart';
import 'package:trashi/pages/profile_screen/components/profile_authentication_text.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class ProfileAuthentication extends StatelessWidget {
  const ProfileAuthentication({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(25,15,25,25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileAuthenticationText(type: "login"),
                ProfileAuthenticationText(type: "register"),
              ],
            ),
            AuthenticationForm(),
          ],
        ),
      ),
    );
  }
}
