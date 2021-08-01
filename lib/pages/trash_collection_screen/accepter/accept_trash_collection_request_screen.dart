import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

import 'components/filter_button.dart';
import 'components/trash_collection_requests.dart';

class AcceptTrashCollectionRequestScreen extends StatefulWidget {
  static const String PATH = "acceptTrashCollecting";

  @override
  _AcceptTrashCollectionRequestScreenState createState() =>
      _AcceptTrashCollectionRequestScreenState();
}

class _AcceptTrashCollectionRequestScreenState
    extends State<AcceptTrashCollectionRequestScreen> {
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
        color: hexToColor("#F2F2F2"),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: _buildBoxDecoration(),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        cursorColor: hexToColor(MAIN_COLOR),
        style: TextStyle(
          fontSize: 16,
          color: hexToColor("#909090"),
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.search,
            size: 16,
            color: hexToColor("#909090"),
          ),
          labelText: "Search",
          labelStyle: TextStyle(
            fontSize: 16,
            color: hexToColor("#909090"),
          ),
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.only(right: 14),
        ),
      ),
    );
  }

  Widget _buildChooseCalendarButton() {
    return RowButtonWrapper(
      height: 32,
      content: Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 14,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 12,
            ),
          ),
          Text(
            context
                        .watch<AcceptTrashCollectionRequestScreenFilter>()
                        .dateTime !=
                    null
                ? getLocaleDate(
                    context
                        .watch<AcceptTrashCollectionRequestScreenFilter>()
                        .dateTime,
                  )
                : getLocaleDate(DateTime.now()),
            style: TextStyle(
              color: hexToColor("#4C4C4C"),
              fontSize: 14,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 14,
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 7, 16, 7),
      circularBorderRadius: 8,
      borderColor: hexToColor("#F2F2F2"),
      backgroundColor: Colors.white,
      foregroundColor: hexToColor("#4C4C4C"),
      onPressed: () {
        _selectDate();
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate:
          context.read<AcceptTrashCollectionRequestScreenFilter>().dateTime ??
              DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      context.read<AcceptTrashCollectionRequestScreenFilter>().dateTime =
          picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(
        "Request Pengambilan",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding: EdgeInsets.only(
              bottom: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChooseCalendarButton(),
              FilterButton(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 21,
            ),
          ),
          TrashCollectionRequests(),
        ],
      ),
    );
  }
}
