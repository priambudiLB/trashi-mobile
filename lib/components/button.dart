import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class Button extends StatelessWidget {
  const Button(
      {Key key,
      @required this.onTap,
      @required this.title,
      this.height,
      this.width,
      this.listTextSpan,
      this.listBoxShadow,
      this.fontWeight,
      this.fontSize,
      this.backgroundColor,
      this.borderColor,
      this.fontColor})
      : super(key: key);

  final double height;
  final double width;
  final double fontSize;
  final String title;
  final Function onTap;
  final List<TextSpan> listTextSpan;
  final List<BoxShadow> listBoxShadow;
  final FontWeight fontWeight;
  final Color fontColor;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    var currentBackground =
        backgroundColor != null ? backgroundColor : hexToColor(MAIN_COLOR);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height != null ? height : 48,
        width: width != null ? width : 200,
        child: Center(
            child: RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
                color: fontColor != null ? fontColor : Colors.white,
                fontWeight: fontWeight != null ? fontWeight : FontWeight.w400,
                fontSize: fontSize != null ? fontSize : 14),
            children: listTextSpan != null ? listTextSpan : [],
          ),
        )),
        decoration: BoxDecoration(
            color: currentBackground,
            boxShadow: listBoxShadow != null ? listBoxShadow : [],
            borderRadius: BorderRadius.circular(8),
            border: borderColor != null
                ? Border.all(width: 1, color: borderColor)
                : Border()),
      ),
    );
  }
}
