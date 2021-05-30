import 'package:flutter/material.dart';

class RowButtonWrapper extends StatelessWidget {
  final Function onPressed;
  final double height;
  final Row content;
  final EdgeInsets padding;
  final double circularBorderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color foregroundColor;

  const RowButtonWrapper({
    Key key,
    this.height,
    this.onPressed,
    this.content,
    this.padding,
    this.circularBorderRadius,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height,
        maxHeight: height,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: content,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius),
              side: BorderSide(
                color: borderColor,
              ),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            foregroundColor,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            padding,
          ),
        ),
      ),
    );
  }
}
