import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/utils/commons.dart';

class RetributionPaymentStatus extends StatefulWidget {
  final int statusCode;

  const RetributionPaymentStatus({
    Key key,
    this.statusCode,
  }) : super(key: key);
  @override
  _RetributionPaymentStatus createState() => _RetributionPaymentStatus();
}

class _RetributionPaymentStatus extends State<RetributionPaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: widget.statusCode == 0 ? hexToColor('#D8224D') : hexToColor('#FF9059'),
            borderRadius: BorderRadius.circular(2)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Center(
            child: Text(
              widget.statusCode == 0 ? 'Payment Overdue' : 'Payment Approved',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 8,
              ),
            ),
          ),
        )
    );
  }
}
