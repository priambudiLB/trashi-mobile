import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/routes.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/date_picker.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_barang_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_berat_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/jenis_kendaraan_dropdown.dart';
import 'package:trashi/pages/form_request_pengangkatan/components/time_picker.dart';
import 'package:trashi/pages/form_request_pengangkatan/detail_pengangkatan.dart';
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
  final picker = ImagePicker();
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
            Wrap(
              spacing: 4.0, // gap between adjacent chips
              runSpacing: 4.0,
              children: getFileListWidget(context),
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
              horizontalTitleGap: 0,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Radio<TimeType>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity(horizontal: -4),
                value: TimeType.NOW,
                groupValue: context
                    .watch<FormRequestPengangkatanProvider>()
                    .selectedTimeType,
                onChanged: (TimeType value) {
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .setTimeType(value);
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .setSelectedDate(null);
                  context
                      .read<FormRequestPengangkatanProvider>()
                      .setSelectedTime(null);
                },
              ),
            ),
            ListTile(
              title: Text("Set Schedule Time"),
              dense: true,
              contentPadding: EdgeInsets.all(0),
              minVerticalPadding: 0,
              horizontalTitleGap: 0,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Radio<TimeType>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity(horizontal: -4),
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
            Container(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: DatePickerComponent()),
                Container(
                  width: 15,
                ),
                Expanded(child: TimePickerComponent())
              ],
            ),
            Container(
              height: 24,
            ),
            Button(
              onTap: () {
                Navigator.push(
                    context, SlideLeftRoute(page: DetailPengangkatan()));
              },
              title: "Lanjut",
              width: double.infinity,
            ),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getFileListWidget(BuildContext context) {
    return List.generate(
        context.watch<FormRequestPengangkatanProvider>().listFile.length + 1,
        (index) {
      if (index ==
          context.read<FormRequestPengangkatanProvider>().listFile.length) {
        return InkWell(
          onTap: () async {
            final pickedFile =
                await picker.getImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              List<File> tmp =
                  context.read<FormRequestPengangkatanProvider>().listFile;
              tmp.add(File(pickedFile.path));
              context.read<FormRequestPengangkatanProvider>().setListFile(tmp);
            }
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#CBCBCB"))),
            child: Icon(
              Icons.add_a_photo,
              size: 30,
            ),
          ),
        );
      } else {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                context.read<FormRequestPengangkatanProvider>().listFile[index],
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    List<File> tmp = context
                        .read<FormRequestPengangkatanProvider>()
                        .listFile;
                    tmp.removeAt(index);
                    context
                        .read<FormRequestPengangkatanProvider>()
                        .setListFile(tmp);
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Icon(
                        Icons.cancel,
                        color: hexToColor("#ED3739"),
                      ),
                    ),
                  ),
                ))
          ],
        );
      }
    });
  }
}
