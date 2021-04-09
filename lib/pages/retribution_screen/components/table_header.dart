import 'package:flutter/material.dart';

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
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        )
    );
  }
}
