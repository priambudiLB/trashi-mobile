import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trashi/http_request/models/range_berat.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class JenisBeratDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<FormRequestPengangkatanProvider>().statusFetchData ==
            FormzStatus.submissionInProgress
        ? SkeletonAnimation(
            child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: hexToColor("#CBCBCB")),
          ))
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#CBCBCB"))),
            child: DropdownButton(
              dropdownColor: Colors.white,
              underline: SizedBox(),
              value: context
                  .watch<FormRequestPengangkatanProvider>()
                  .selectedBeratBarang,
              isExpanded: true,
              hint: Text(
                "Berat Barang",
                style: TextStyle(color: hexToColor("#C4C4C4")),
              ),
              items: context
                  .watch<FormRequestPengangkatanProvider>()
                  .listBeratBarang
                  .map<DropdownMenuItem<RangeBerat>>((RangeBerat item) {
                return DropdownMenuItem<RangeBerat>(
                    value: item, child: Text(item.range));
              }).toList(),
              onChanged: (RangeBerat newBeratBarang) {
                context
                    .read<FormRequestPengangkatanProvider>()
                    .setSelectedBeratBarang(newBeratBarang);
              },
            ),
          );
  }
}
