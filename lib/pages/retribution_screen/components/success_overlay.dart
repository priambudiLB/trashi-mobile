import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/overlay.dart';
import 'package:trashi/utils/commons.dart';

class SuccessOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlayTemplate(
      height: 200,
      child: Column(
        children: [
          SvgPicture.asset('assets/images/icon_success.svg'),
          Text('a')
        ],
      ),
    );
  }
}
