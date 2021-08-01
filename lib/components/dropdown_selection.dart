import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class DropdownSelection<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getLabel;
  final Function(T) onChanged;

  const DropdownSelection({
    Key key,
    @required this.items,
    @required this.getLabel,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownSelectionState<T> createState() => _DropdownSelectionState<T>();
}

class _DropdownSelectionState<T> extends State<DropdownSelection<T>> {
  T _value;

  set value(T newValue) {
    setState(() {
      _value = newValue;
    });
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
        child: DropdownButton<T>(
          isExpanded: true,
          value: _value,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          onChanged: (T newValue) {
            widget.onChanged(newValue);
            value = newValue;
          },
          isDense: true,
          items: widget.items?.map<DropdownMenuItem<T>>(
            (T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(widget.getLabel(value)),
              );
            },
          )?.toList(),
        ),
      ),
    );
  }
}