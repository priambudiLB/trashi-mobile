import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/kendaraan.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class JenisKendaraanDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<FormRequestPengangkatanProvider>().listKendaraan ==
            null
        ? Container()
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
                  .map<DropdownMenuItem<Kendaraan>>((Kendaraan item) {
                return DropdownMenuItem<Kendaraan>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (Kendaraan newKendaraan) {
                context
                    .read<FormRequestPengangkatanProvider>()
                    .setSelectedKendaraan(newKendaraan);
              },
            ),
          );
  }
}
