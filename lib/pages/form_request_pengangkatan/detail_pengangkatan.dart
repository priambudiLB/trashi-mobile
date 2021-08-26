import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:formz/formz.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/pages/payment/payment_web_view_screen.dart';
import 'package:trashi/utils/commons.dart';

import 'package:provider/provider.dart';

class DetailPengangkatan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context
            .watch<FormRequestPengangkatanProvider>()
            .statusSubmitLanjutPembayaran ==
        FormzStatus.submissionSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context
            .read<FormRequestPengangkatanProvider>()
            .setStatusSubmitLanjutPembayaran(FormzStatus.pure);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebViewScreen(
              url: context
                  .read<FormRequestPengangkatanProvider>()
                  .pembayaranPengatan
                  .invoiceURL,
            ),
          ),
        );
      });
    }
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
          context.read<FormRequestPengangkatanProvider>().selectedBarang.nama,
          style: TextStyle(
              fontSize: 14,
              color: hexToColor("#4D4D4D"),
              fontWeight: FontWeight.w500),
        ),
        Container(
          height: 16,
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
          context
              .read<FormRequestPengangkatanProvider>()
              .selectedBeratBarang
              .range,
          style: TextStyle(
              fontSize: 14,
              color: hexToColor("#4D4D4D"),
              fontWeight: FontWeight.w500),
        ),
        Container(
          height: 16,
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
          context
                  .read<FormRequestPengangkatanProvider>()
                  .selectedKendaraan
                  .kendaraan +
              " & " +
              context
                  .read<FormRequestPengangkatanProvider>()
                  .selectedKendaraan
                  .dp
                  .toString(),
          style: TextStyle(
              fontSize: 14,
              color: hexToColor("#4D4D4D"),
              fontWeight: FontWeight.w500),
        ),
        Container(
          height: 16,
        ),
        Text(
          "Lokasi",
          style: TextStyle(
              fontSize: 12,
              color: hexToColor("#909090"),
              fontWeight: FontWeight.w400),
        ),
        Container(
          height: 8,
        ),
        Text(
          context
              .read<FormRequestPengangkatanProvider>()
              .selectedLocation
              .toString(),
          style: TextStyle(
              fontSize: 14,
              color: hexToColor("#4D4D4D"),
              fontWeight: FontWeight.w500),
        ),
        Container(
          height: 32,
        ),
        context
                    .watch<FormRequestPengangkatanProvider>()
                    .statusSubmitLanjutPembayaran ==
                FormzStatus.submissionInProgress
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Button(
                onTap: () {
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .submitLanjutPembayaran();
                },
                width: double.infinity,
                title: "Lanjut Pembayaran")
      ],
    ));
  }
}
