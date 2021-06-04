import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/pages/retribution_screen/components/month_item.dart';
import 'package:trashi/pages/retribution_screen/components/year_dropdown.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Status extends StatelessWidget {
  Status(this.status);

  final int status;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return Container(
          // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                color: hexToColor('#F5FAF9'),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Center(
              child: Text(
                "Approved",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: hexToColor('#32A37F'),
                  fontSize: 10,
                ),
              ),
            )
        );
        break;
      case 1:
        return Container(
          // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                color: hexToColor('#FFEFE8'),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Center(
              child: Text(
                "Overdue",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: hexToColor('#FF5252'),
                  fontSize: 10,
                ),
              ),
            )
        );
        break;
      case 2:
        return Container(
          // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: hexToColor('#909090')),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Center(
              child: Text(
                "Approve",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: hexToColor('#909090'),
                  fontSize: 10,
                ),
              ),
            )
        );
        break;
    }
  }
}
