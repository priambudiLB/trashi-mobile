import 'package:flutter/material.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/pages/retribution_screen/components/status.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/utils/commons.dart';

class TableBody extends StatefulWidget {
  final Retribusi retribusi;

  const TableBody({
    Key key,
    this.retribusi,
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
    int isApprovedCount = 0;

    widget.retribusi.statuses.forEach((element) {
      if (element.isApproved) {
        isApprovedCount++;
      }
    });

    final isApproved = isApprovedCount == widget.retribusi.statuses.length;

    if (isApproved) {
      return Status(0);
    }

    return Status(2);
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
                content: _buildTextContent(widget.retribusi.idTransaksi),
                flex: 6,
              ),
              TableBodyContent(
                content: _buildTextContent(widget.retribusi.tarif.toString()),
                flex: 6,
              ),
              TableBodyContent(
                content: _buildTextContent(widget.retribusi.alamat),
                flex: 10,
              ),
              TableBodyContent(
                content: _buildStatus(),
                flex: 6,
              ),
            ],
          ),
        ));
  }
}
