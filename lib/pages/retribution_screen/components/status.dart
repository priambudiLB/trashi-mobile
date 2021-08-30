import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/constants/retribution_status.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/pages/retribution_screen/provider/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Status extends StatelessWidget {
  final GetRetribusiListItemResponse getRetribusiListItemResponse;
  final int status;

  Status({
    @required this.status,
    @required this.getRetribusiListItemResponse,
  });

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<RetribusiAllItemResponse>(
          items: getRetribusiListItemResponse.all
              .map(
                (element) => MultiSelectItem(element, element.monthText),
              )
              .toList(),
          initialValue: context.watch<RetributionProvider>().toBeApprovedValues[
                  context
                      .read<RetributionProvider>()
                      .generateKeyForToBeApprovedValues(
                        getRetribusiListItemResponse.now,
                      )] ??
              [],
          onConfirm: (values) {
            RetributionProvider provider = context.read<RetributionProvider>();
            if (!provider.areMonthsToBeApprovedOK(
              values,
              getRetribusiListItemResponse.all,
            )) {
              ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(
                  message:
                      'Approval harus dilakukan untuk tagihan bulan yang muncul terlebih dahulu.'));
              return;
            }

            provider.addToBeApprovedValue(
              provider.generateKeyForToBeApprovedValues(
                getRetribusiListItemResponse.now,
              ),
              values,
            );
          },
          title: Text('Pilih Bulan'),
          initialChildSize: 0.4,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return Container(
            // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                color: hexToColor('#F5FAF9'),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(
                "Approved",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: hexToColor('#32A37F'),
                  fontSize: 10,
                ),
              ),
            ));
        break;
      case 1:
        return Container(
            // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                color: hexToColor('#FFEFE8'),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(
                "Overdue",
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  color: hexToColor('#FF5252'),
                  fontSize: 10,
                ),
              ),
            ));
        break;
      case 2:
        return Container(
            // width: 1000,
            height: 16,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: hexToColor('#909090')),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: InkWell(
              child: Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w400,
                    color: hexToColor('#909090'),
                    fontSize: 10,
                  ),
                ),
              ),
              onTap: () {
                print('on tap approve');
                _showMultiSelect(context);
              },
            ));
        break;
    }
  }
}
