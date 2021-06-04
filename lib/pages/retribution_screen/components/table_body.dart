import 'package:flutter/material.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/utils/commons.dart';

class TableBody extends StatefulWidget {
  final int index;
  final List<Widget> items;
  final Widget idTransaksi;
  final Widget tarif;
  final Widget alamatRumah;
  final Widget approval;


  const TableBody({
    Key key,
    this.index,
    this.items,
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
          border: Border(
            top: BorderSide(
                width: 1,
                color: hexToColor('#F2F2F2'),
            )
          ),
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
                content: widget.items[0],
                flex: 6,
              ),
              TableBodyContent(
                content: widget.items[1],
                flex: 6,
              ),
              TableBodyContent(
                content: widget.items[2],
                flex: 10,
              ),
              TableBodyContent(
                content: widget.items[3],
                flex: 6,
              ),
            ],
          ),
        )
    );
  }
}
