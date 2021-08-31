import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/retribution_screen/components/payment.dart';
import 'package:trashi/utils/commons.dart';

class RetributionScreen extends StatefulWidget {
  static const String PATH = "retribution";

  @override
  _RetributionScreenState createState() => _RetributionScreenState();
}

class _RetributionScreenState extends State<RetributionScreen> {
  _buildSearchField(String label) {
    TextFormField textFormField = TextFormField(
      cursorColor: hexToColor('#909090'),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 15),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.search,
            color: hexToColor('#909090'),
          ), // icon is 48px widget.
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: hexToColor("#909090"), width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          height: 48,
          child: textFormField,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Layout(
          height: 40,
          title: Text(
            "Pembayaran Retribusi",
            // textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: "Avenir",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20),
          ),
          body: ListView(
            children: [
              Container(
                  // child: _buildSearchField('Search'),
                  // margin: EdgeInsets.only(top: 16),
                  ),
              Payment(),
            ],
          ),
        ),
        // SuccessOverlay()
      ],
    );
  }
}
