import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/pages/payment/payment_web_view_screen.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Status extends StatelessWidget {
  final RetribusiNowResponse getRetribusiListItemResponse;
  final int status;

  Status({
    @required this.status,
    @required this.getRetribusiListItemResponse,
  });

  @override
  Widget build(BuildContext context) {
    print(status);
    switch (status) {
      case 1:
        return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width: 0.5, color: hexToColor('#909090')),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(
                "Bayar",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          onTap: () {
            context
                .read<RetributionMasyarakatProvider>()
                .createPembayaranRetribusi(
                    getRetribusiListItemResponse.rumah.tarifRetribusi,
                    getRetribusiListItemResponse.id);
          },
        );
        break;
      case 3:
        return Container(
            // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                color: hexToColor(MAIN_COLOR),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(
                "Lunas",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ));
        break;
      case 2:
        return Container(
            // width: 1000,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width: 0.5, color: hexToColor('#909090')),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: InkWell(
              child: Center(
                //TODO ganti sesuai
                child: Text(
                  "Overdue",
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              onTap: () {
                context
                    .read<RetributionMasyarakatProvider>()
                    .createPembayaranRetribusi(
                        getRetribusiListItemResponse.rumah.tarifRetribusi,
                        getRetribusiListItemResponse.id);
              },
            ));
        break;
    }
  }
}
