import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/constants/colors.dart';

class NewsSearchBar extends StatefulWidget {
  final String magnifierImageLocation =
      "assets/images/magnifier-news-search.png";
  final String worldImageLocation = "assets/images/world-news-search.png";
  final double magnifierImageWidthAndHeight = 20;
  final double worldImageLocationSquareSizeWidthAndHeight = 40;
  final String searchNewsHintText = "search news";
  final double searchNewsHintFontSize = 10;
  final double textFieldWidth = 165;
  final double textFieldRightAndLeft = 10;
  final double textFieldAndRightImageDistance = 10;

  @override
  _NewsSearchBarState createState() => _NewsSearchBarState();
}

class _NewsSearchBarState extends State<NewsSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: hexToColor(MAIN_COLOR),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
              ))),
              child: Row(
                children: [
                  Image.asset(
                    widget.magnifierImageLocation,
                    width: widget.magnifierImageWidthAndHeight,
                    height: widget.magnifierImageWidthAndHeight,
                  ),
                  Container(
                    width: widget.textFieldWidth,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.searchNewsHintText,
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: widget.searchNewsHintFontSize,
                        ),
                        contentPadding: EdgeInsets.only(
                            left: widget.textFieldRightAndLeft,
                            right: widget.textFieldRightAndLeft),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(
                  right: widget.textFieldAndRightImageDistance)),
          Image.asset(
            widget.worldImageLocation,
            width: widget.worldImageLocationSquareSizeWidthAndHeight,
            height: widget.worldImageLocationSquareSizeWidthAndHeight,
          )
        ],
      ),
    );
  }
}
