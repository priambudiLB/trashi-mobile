import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({
    Key key,
  }) : super(key: key);
  @override
  _CalendarPicker createState() => _CalendarPicker();
}

class _CalendarPicker extends State<CalendarPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RetributionPayment>().setPopupDateOpen(true);
      },
      child: Container(
          decoration: BoxDecoration(
              color: hexToColor('#EEEFEF'),
              borderRadius: BorderRadius.circular(3)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/ic-calendar.svg'),
                Container(width: 4),
                Text(
                  context.watch<RetributionPayment>().date,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
      )
    );
  }
}
