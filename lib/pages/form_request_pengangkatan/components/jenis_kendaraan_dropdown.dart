import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trashi/http_request/models/kendaraan_dp.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class JenisKendaraanDropdown extends StatelessWidget {
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
                  .selectedKendaraan,
              isExpanded: true,
              hint: Text(
                "Pilih Kendaraan dan DP",
                style: TextStyle(color: hexToColor("#C4C4C4")),
              ),
              items: context
                  .watch<FormRequestPengangkatanProvider>()
                  .listKendaraan
                  .map<DropdownMenuItem<KendaraanDanDP>>((KendaraanDanDP item) {
                return DropdownMenuItem<KendaraanDanDP>(
                  value: item,
                  child: Text(item.kendaraan + " & " + item.dp.toString()),
                );
              }).toList(),
              onChanged: (KendaraanDanDP newKendaraan) {
                context
                    .read<FormRequestPengangkatanProvider>()
                    .setSelectedKendaraan(newKendaraan);
              },
            ),
          );
  }
}
