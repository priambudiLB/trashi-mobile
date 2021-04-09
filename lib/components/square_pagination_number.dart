import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/utils/commons.dart';

class SquarePaginationNumber extends StatefulWidget {
  final String number;
  final Color backgroundColor;
  final Function onTap;

  const SquarePaginationNumber({
    Key key,
    this.number,
    this.backgroundColor,
    this.onTap
  }) : super(key: key);
  @override
  _SquarePaginationNumber createState() => _SquarePaginationNumber();
}

class _SquarePaginationNumber extends State<SquarePaginationNumber> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: 18,
          height: 18,
          color: widget.backgroundColor,
          child: Center(
            child: Text(
              widget.number,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          )
      ),
    );
  }
}
