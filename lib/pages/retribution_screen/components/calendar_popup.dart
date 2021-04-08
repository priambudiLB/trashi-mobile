import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/pages/retribution_screen/components/month_item.dart';
import 'package:trashi/pages/retribution_screen/components/year_dropdown.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class CalendarPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<RetributionPayment>().popupDateOpen) return Container();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(80,151,97,0.4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            height: 184,
            width: double.infinity,
            decoration: BoxDecoration(
                color: hexToColor('#304860'),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  YearDropdown(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MonthItem(month: "Jan"),
                      MonthItem(month: "Feb"),
                      MonthItem(month: "Mar"),
                      MonthItem(month: "Apr"),
                      MonthItem(month: "May"),
                      MonthItem(month: "Jun"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MonthItem(month: "Jul"),
                      MonthItem(month: "Aug"),
                      MonthItem(month: "Sep"),
                      MonthItem(month: "Oct"),
                      MonthItem(month: "Nov"),
                      MonthItem(month: "Dec"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<RetributionPayment>().setDate();
                          context.read<RetributionPayment>().setPopupDateOpen(false);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: hexToColor('#7CC599')
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/images/ic-send.svg'
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
