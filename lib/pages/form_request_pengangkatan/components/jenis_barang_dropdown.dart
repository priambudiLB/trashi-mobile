import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class JenisBarangDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<FormRequestPengangkatanProvider>().listBarang == null
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
                  .selectedBarang,
              isExpanded: true,
              hint: Text(
                "Pilih Jenis Barang",
                style: TextStyle(color: hexToColor("#C4C4C4")),
              ),
              items: context
                  .watch<FormRequestPengangkatanProvider>()
                  .listBarang
                  .map<DropdownMenuItem<Barang>>((Barang item) {
                return DropdownMenuItem<Barang>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (Barang newBarang) {
                context
                    .read<FormRequestPengangkatanProvider>()
                    .setSelectedBarang(newBarang);
              },
            ),
          );
  }
}
