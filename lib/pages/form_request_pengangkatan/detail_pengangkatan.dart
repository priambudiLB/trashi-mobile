import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

import 'package:provider/provider.dart';

class DetailPengangkatan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detail Pengangkatan",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: hexToColor("#4D4D4D")),
        ),
        Container(
          height: 20,
        ),
        Text(
          "Jenis Barang",
          style: TextStyle(
              fontSize: 12,
              color: hexToColor("#909090"),
              fontWeight: FontWeight.w400),
        ),
        Container(
          height: 8,
        ),
        Text(
          context.read<FormRequestPengangkatanProvider>().selectedBarang.name,
          style: TextStyle(),
        ),
        Text(
          "Berat",
          style: TextStyle(
              fontSize: 12,
              color: hexToColor("#909090"),
              fontWeight: FontWeight.w400),
        ),
        Container(
          height: 8,
        ),
        Text(
          "Jenis Kendaraan dan DP",
          style: TextStyle(
              fontSize: 12,
              color: hexToColor("#909090"),
              fontWeight: FontWeight.w400),
        ),
        Container(
          height: 8,
        ),
        Text(
          "Lokasi",
          style: TextStyle(
              fontSize: 12,
              color: hexToColor("#909090"),
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
