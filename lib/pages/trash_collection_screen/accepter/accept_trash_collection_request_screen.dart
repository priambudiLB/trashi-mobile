import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

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
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 14,
          ),
          Text(
            "1 Januari 2021",
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
    );
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
            children: [
              _buildChooseCalendarButton(),
            ],
          )
        ],
      ),
    );
  }
}
