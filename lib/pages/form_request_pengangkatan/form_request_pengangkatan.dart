import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_barang_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_berat_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_kendaraan_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/time_type.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class FormRequestPengangkatan extends StatefulWidget {
  static const String PATH = "form_request_pengangkatan";

  @override
  _FormRequestPengangkatanState createState() =>
      _FormRequestPengangkatanState();
}

class _FormRequestPengangkatanState extends State<FormRequestPengangkatan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormRequestPengangkatanProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(
        "Request Pengangkatan",
        style: TextStyle(
          color: hexToColor("#4C4C4C"),
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
        textAlign: TextAlign.end,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambahkan Foto",
              style: TextStyle(color: hexToColor("#4D4D4D"), fontSize: 14),
            ),
            Container(
              height: 12,
            ),
            Container(
              height: 24,
            ),
            Text("Pilih Jenis Barang",
                style: TextStyle(color: hexToColor("#4D4D4D"), fontSize: 14)),
            Container(
              height: 12,
            ),
            JenisBarangDropdown(),
            Container(
              height: 24,
            ),
            Text("Berat",
                style: TextStyle(color: hexToColor("#4D4D4D"), fontSize: 14)),
            Container(height: 12),
            JenisBeratDropdown(),
            Container(
              height: 24,
            ),
            Text("Jenis Kendaraan dan DP",
                style: TextStyle(color: hexToColor("#4D4D4D"), fontSize: 14)),
            Container(
              height: 12,
            ),
            JenisKendaraanDropdown(),
            Container(
              height: 24,
            ),
            Text("Pilih Waktu",
                style: TextStyle(color: hexToColor("#4D4D4D"), fontSize: 14)),
            ListTile(
              title: Text("Now"),
              dense: true,
              contentPadding: EdgeInsets.all(0),
              minVerticalPadding: 0,
              leading: Radio<TimeType>(
                value: TimeType.NOW,
                groupValue: context
                    .watch<FormRequestPengangkatanProvider>()
                    .selectedTimeType,
                onChanged: (TimeType value) {
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .setTimeType(value);
                },
              ),
            ),
            ListTile(
              title: Text("Set Schedule Time"),
              dense: true,
              contentPadding: EdgeInsets.all(0),
              minVerticalPadding: 0,
              leading: Radio<TimeType>(
                value: TimeType.SCHEDULED_TIME,
                groupValue: context
                    .watch<FormRequestPengangkatanProvider>()
                    .selectedTimeType,
                onChanged: (TimeType value) {
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .setTimeType(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
