import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/constants/time.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/components/table_body.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/components/table_header.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/provider.dart';
import 'package:trashi/pages/retribution_screen/components/filter_button.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/simple_button.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({
    Key key,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isFirstTimeOpened = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<RetributionMasyarakatProvider>().fetchData();

      setState(() {
        isFirstTimeOpened = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<RetributionMasyarakatProvider>().isFetching ||
            isFirstTimeOpened
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                          getCurrentMonthYear(),
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
                      border:
                          Border.all(width: 1, color: hexToColor('#F2F2F2')),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
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
                          children: context
                              .watch<RetributionMasyarakatProvider>()
                              .data
                              .map(
                                (item) => TableBody(
                                  getRetribusiListItemResponse: item,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 4, bottom: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                 child: Text(
                //                   "Prev",
                //                   style: TextStyle(
                //                     fontFamily: "Avenir",
                //                     fontWeight: FontWeight.w400,
                //                     color: hexToColor('#C4C4C4'),
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               )),
                //         ),
                //       ),
                //       Container(
                //         width: 16,
                //       ),
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                   child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text(
                //                     "Page 1",
                //                     style: TextStyle(
                //                       fontFamily: "Avenir",
                //                       fontWeight: FontWeight.w400,
                //                       color: hexToColor('#464646'),
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                   SvgPicture.asset(
                //                       'assets/images/ic-chevron.svg'),
                //                 ],
                //               ))),
                //         ),
                //       ),
                //       Container(
                //         width: 16,
                //       ),
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                 child: Text(
                //                   "Next",
                //                   style: TextStyle(
                //                     fontFamily: "Avenir",
                //                     fontWeight: FontWeight.w400,
                //                     color: hexToColor('#464646'),
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               )),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
  }
}
