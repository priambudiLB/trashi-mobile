import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class TableHeader extends StatefulWidget {
  final String text;
  final int flex;

  const TableHeader({
    Key key,
    this.text,
    this.flex
  }) : super(key: key);
  @override
  _TableHeader createState() => _TableHeader();
}

class _TableHeader extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: widget.flex,
        fit: FlexFit.tight,
        child: Container(
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Avenit",
                fontWeight: FontWeight.w800,
                color: hexToColor('#464646'),
                fontSize: 12,
              ),
            ),
          ),
        )
    );
  }
}
