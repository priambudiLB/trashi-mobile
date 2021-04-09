import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class MonthItem extends StatefulWidget {
  final String month;

  const MonthItem({
    Key key,
    this.month,
  }) : super(key: key);
  @override
  _MonthItem createState() => _MonthItem();
}

class _MonthItem extends State<MonthItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RetributionPayment>().setMonth(widget.month);
      },
      child: Container(
        decoration: BoxDecoration(
            color: context
                .watch<RetributionPayment>()
                .chosenMonth == widget.month ?
            hexToColor('#DFDFDF') : Colors.white
        ),
        width: 30,
        height: 30,
        child: Center(
          child: Text(
            widget.month,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
