import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class DropdownFilter extends StatefulWidget {
  final String initValue;
  final List<String> list;

  const DropdownFilter({
    Key key,
    this.initValue,
    this.list,
  }) : super(key: key);

  @override
  _DropdownFilterState createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String dropdownValue;
  List<String> list;

  @override
  void initState() {
    dropdownValue = widget.initValue;
    list = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: hexToColor("#CBCBCB"),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          onChanged: (String newValue) {
            setState(
              () {
                dropdownValue = newValue;
              },
            );
          },
          isDense: true,
          items: list.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
