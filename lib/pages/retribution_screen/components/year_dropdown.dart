import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';

class YearDropdown extends StatefulWidget {
  const YearDropdown({Key key}) : super(key: key);

  @override
  _YearDropdown createState() => _YearDropdown();
}

class _YearDropdown extends State<YearDropdown> {
  String dropdownValue;

  void initState() {
    dropdownValue = context.read<RetributionPayment>().chosenYear;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = [
      for (
      var i=int.parse(DateFormat('y').format(new DateTime.now()));
      i>int.parse(DateFormat('y').format(new DateTime.now())) - 20;
      i-=1
      ) i.toString()
    ];
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          // icon: const Icon(Icons.arrow_downward),
          // iconSize: 24,
          style: TextStyle(color: Colors.black),
          onChanged: (String newValue) {
            context.read<RetributionPayment>().setYear(newValue);
            setState(() {
              dropdownValue = newValue;
            });
          },
          isDense: true,
          items: list
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      )
    );
  }
}