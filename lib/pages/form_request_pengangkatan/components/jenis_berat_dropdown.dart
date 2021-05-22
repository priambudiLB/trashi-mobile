import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/berat_barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class JenisBeratDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<FormRequestPengangkatanProvider>().listBeratBarang ==
            null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#CBCBCB"))),
            child: DropdownButton(
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
                  .map<DropdownMenuItem<BeratBarang>>((BeratBarang item) {
                return DropdownMenuItem<BeratBarang>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (BeratBarang newBeratBarang) {
                context
                    .read<FormRequestPengangkatanProvider>()
                    .setSelectedBeratBarang(newBeratBarang);
              },
            ),
          );
  }
}
