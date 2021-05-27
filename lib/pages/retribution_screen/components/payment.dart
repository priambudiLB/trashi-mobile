import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/calendar_picker.dart';
import 'package:trashi/components/square_pagination_number.dart';
import 'package:trashi/pages/retribution_screen/components/table_body.dart';
import 'package:trashi/pages/retribution_screen/components/table_header.dart';
import 'package:trashi/utils/commons.dart';

class Payment extends StatelessWidget {
  const Payment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> paymentData = [];

    paymentData.add({
      'idTransaksi': 'RBS 00307',
      'tarif': '50000',
      'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
    });
    paymentData.add({
      'idTransaksi': 'RBS 00307',
      'tarif': '50000',
      'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
    });
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Payments',
                    style: TextStyle(
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                      color: hexToColor('#464646'),
                      fontSize: 16,
                    ),
                  ),
                  Container(height: 4),
                  Text(
                    'Januari, 2020',
                    style: TextStyle(
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w400,
                      color: hexToColor('#464646'),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Filter()
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 10),
            decoration: BoxDecoration(
              // color: hexToColor('#304860'),
              border: Border.all(width: 1, color: hexToColor('#F2F2F2')),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
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
                          text: 'Status',
                          flex: 4,
                        ),
                      ],
                    ),
                  ),
                  Column(
                      children: paymentData.map(
                              (item) => TableBody(
                            index: paymentData.indexOf(item),
                            items: [
                              Text(
                                item['idTransaksi'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor('#4D4D4D'),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                item['tarif'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor('#4D4D4D'),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                item['alamatRumah'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor('#4D4D4D'),
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
                ],
              )
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                        width: 1000,
                        height: 32,
                        decoration: BoxDecoration(
                          // color: hexToColor('#304860'),
                            border: Border.all(width: 1, color: hexToColor('#CBCBCB')),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Center(
                          child: Text(
                            "Prev",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w400,
                              color: hexToColor('#C4C4C4'),
                              fontSize: 12,
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                Container(width: 16,),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                        width: 1000,
                        height: 32,
                        decoration: BoxDecoration(
                          // color: hexToColor('#304860'),
                            border: Border.all(width: 1, color: hexToColor('#CBCBCB')),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Page 1",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor('#464646'),
                                  fontSize: 12,
                                ),
                              ),
                              SvgPicture.asset('assets/images/ic-chevron.svg'),
                            ],
                          )
                        )
                    ),
                  ),
                ),
                Container(width: 16,),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                        width: 1000,
                        height: 32,
                        decoration: BoxDecoration(
                          // color: hexToColor('#304860'),
                            border: Border.all(width: 1, color: hexToColor('#CBCBCB')),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w400,
                              color: hexToColor('#464646'),
                              fontSize: 12,
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
