import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({
    Key key,
  }) : super(key: key);
  @override
  _Filter createState() => _Filter();
}

class _Filter extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RetributionPayment>().setPopupDateOpen(true);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hexToColor('#F2F2F2')
              )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/ic-filter.svg'),
                Container(width: 12),
                Text(
                  "Filter",
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
      )
    );
  }
}
