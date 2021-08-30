import 'package:flutter/material.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/components/status.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/utils/commons.dart';

class TableBody extends StatefulWidget {
  final RetribusiNowResponse getRetribusiListItemResponse;

  const TableBody({
    Key key,
    this.getRetribusiListItemResponse,
  }) : super(key: key);
  @override
  _TableBody createState() => _TableBody();
}

class _TableBody extends State<TableBody> {
  Text _buildTextContent(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Avenir",
        fontWeight: FontWeight.w500,
        color: hexToColor('#4D4D4D'),
        fontSize: 12,
      ),
    );
  }

  Status _buildStatus() {
    return Status(
      status: widget.getRetribusiListItemResponse.status,
      getRetribusiListItemResponse: widget.getRetribusiListItemResponse,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
          width: 1,
          color: hexToColor('#F2F2F2'),
        )),
        // color: widget.index % 2 == 0 ? hexToColor('#DFDFDF') : hexToColor('#FFFFFF'),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Row(
          // children: widget.items,
          children: [
            TableBodyContent(
              content: _buildTextContent(
                  widget.getRetribusiListItemResponse.rumah.fullName),
              flex: 6,
            ),
            TableBodyContent(
              content: _buildTextContent(widget
                  .getRetribusiListItemResponse.rumah.tarifRetribusi
                  .toString()),
              flex: 6,
            ),
            TableBodyContent(
              content: _buildTextContent(
                  widget.getRetribusiListItemResponse.rumah.alamat),
              flex: 10,
            ),
            TableBodyContent(
              content: _buildStatus(),
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
