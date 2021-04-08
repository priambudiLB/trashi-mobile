import 'package:flutter/material.dart';
import 'package:trashi/components/calendar_picker.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/pages/retribution_screen/components/table_header.dart';
import 'package:trashi/utils/commons.dart';

class TableBody extends StatefulWidget {
  final Widget idTransaksi;
  final Widget tarif;
  final Widget alamatRumah;
  final Widget approval;


  const TableBody({
    Key key,
    this.idTransaksi,
    this.tarif,
    this.alamatRumah,
    this.approval,
  }) : super(key: key);
  @override
  _TableBody createState() => _TableBody();
}

class _TableBody extends State<TableBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: hexToColor('#DFDFDF'),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: Row(
            children: [
              TableBodyContent(
                content: widget.idTransaksi,
                flex: 4,
              ),
              TableBodyContent(
                content: widget.tarif,
                flex: 4,
              ),
              TableBodyContent(
                content: widget.alamatRumah,
                flex: 6,
              ),
              TableBodyContent(
                content: widget.approval,
                flex: 4,
              ),
            ],
          ),
        )
    );
  }
}
