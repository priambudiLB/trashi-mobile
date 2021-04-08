import 'package:flutter/material.dart';
import 'package:trashi/components/calendar_picker.dart';
import 'package:trashi/components/square_pagination_number.dart';
import 'package:trashi/pages/retribution_screen/components/table_body.dart';
import 'package:trashi/pages/retribution_screen/components/table_header.dart';
import 'package:trashi/utils/commons.dart';

class WaitingForPayment extends StatelessWidget {
  const WaitingForPayment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> waitingForPaymentData = [];

    waitingForPaymentData.add({
      'idTransaksi': 'RBS 00307',
      'tarif': '50000',
      'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
    });
    waitingForPaymentData.add({
      'idTransaksi': 'RBS 00307',
      'tarif': '50000',
      'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
    });
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
          Column(
            children: waitingForPaymentData.map(
              (item) => TableBody(
                index: waitingForPaymentData.indexOf(item),
                items: [
                  Text(
                    item['idTransaksi'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    item['tarif'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    item['alamatRumah'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Image.asset(
                    'assets/images/ic-approve.png',
                    width: 25,
                  )
                ],
              )
            ).toList()
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SquarePaginationNumber(
                  onTap: (){},
                  number: "1",
                  backgroundColor: hexToColor('#DFDFDF'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
