import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class SimpleTextButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Function() onPressed;

  const SimpleTextButton({
    Key key,
    @required this.label,
    this.backgroundColor = Colors.white,
    this.textColor,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Container(
        child: TextButton(
          onPressed: () => onPressed(),
          child: Text(
            label,
            style: TextStyle(
              color: textColor ?? hexToColor(MAIN_COLOR),
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
              side: BorderSide(
                color: hexToColor(MAIN_COLOR),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
