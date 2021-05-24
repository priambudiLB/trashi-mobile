import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/filter_screen.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/commons.dart';

class FilterButton extends StatefulWidget {
  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  openFilterDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RowButtonWrapper(
      height: 32,
      content: Row(
        children: [
          SvgPicture.asset('assets/images/filter_icon_trashi.svg'),
          Padding(
            padding: EdgeInsets.only(
              right: 12,
            ),
          ),
          Text(
            "Filter",
            style: TextStyle(
              color: hexToColor("#4C4C4C"),
              fontSize: 14,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
      circularBorderRadius: 8,
      borderColor: hexToColor("#F2F2F2"),
      backgroundColor: Colors.white,
      foregroundColor: hexToColor("#4C4C4C"),
      onPressed: () {
        openFilterDialog(context);
      },
    );
  }
}
