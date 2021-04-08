import 'package:flutter/material.dart';
import 'package:trashi/components/calendar_picker.dart';
import 'package:trashi/pages/retribution_screen/components/table_body.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/pages/retribution_screen/components/table_header.dart';
import 'package:trashi/utils/commons.dart';

class WaitingForPayment extends StatelessWidget {
  const WaitingForPayment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Waiting For Payment',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              CalendarPicker()
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 6, bottom: 10),
            decoration: BoxDecoration(
              color: hexToColor('#304860'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
              )
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: Row(
                children: [
                  TableHeader(
                    text: 'ID\nTransaksi',
                    flex: 4,
                  ),
                  TableHeader(
                    text: 'Tarif',
                    flex: 4,
                  ),
                  TableHeader(
                    text: 'Alamat Rumah',
                    flex: 6,
                  ),
                  TableHeader(
                    text: 'Approval',
                    flex: 4,
                  ),
                ],
              ),
            )
          ),
          TableBody(
            idTransaksi: Text(
              'ID\nTransaksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            tarif: Text(
              'ID\nTransaksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            alamatRumah: Text(
              'ID\nTransaksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            approval: Text(
              'ID\nTransaksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
