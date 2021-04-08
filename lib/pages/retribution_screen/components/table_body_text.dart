import 'package:flutter/material.dart';
import 'package:trashi/components/calendar_picker.dart';
import 'package:trashi/utils/commons.dart';

class TableBodyContent extends StatefulWidget {
  final Widget content;
  final int flex;

  const TableBodyContent({
    Key key,
    this.content,
    this.flex
  }) : super(key: key);
  @override
  _TableBodyContent createState() => _TableBodyContent();
}

class _TableBodyContent extends State<TableBodyContent> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: widget.flex,
        fit: FlexFit.tight,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Center(
                child: widget.content
            ),
          )
        )
    );
  }
}
