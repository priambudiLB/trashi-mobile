import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/routes.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/pages/form_request_pengangkatan/location_picker_form.dart';

import 'history/collection_history_screen.dart';

class RequestScreen extends StatelessWidget {
  static const String PATH = "request_screen";
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(""),
      body: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context, SlideLeftRoute(page: LocationPickerForm()));
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Request Pengangkatan",
                        style: TextStyle(
                            fontSize: 16,
                            color: hexToColor("#464646"),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 8,
                      ),
                      Text(
                        "Request pengangkatan sampah",
                        style: TextStyle(
                            fontSize: 12, color: hexToColor("#909090")),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_outlined,
                  size: 40,
                  color: hexToColor("#4C4C4C"),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 1,
            width: double.infinity,
            color: hexToColor("#DFDFDF"),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                SlideLeftRoute(
                  page: CollectionHistoryScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Histori Pengangkatan",
                        style: TextStyle(
                            fontSize: 16,
                            color: hexToColor("#464646"),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 8,
                      ),
                      Text(
                        "Lihat histori pengangkatan sampah",
                        style: TextStyle(
                            fontSize: 12, color: hexToColor("#909090")),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_outlined,
                  size: 40,
                  color: hexToColor("#4C4C4C"),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 1,
            width: double.infinity,
            color: hexToColor("#DFDFDF"),
          ),
        ],
      ),
    );
  }
}
