import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                Expanded(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: hexToColor("#CBCBCB"))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                          ),
                          Container(
                            width: 12,
                          ),
                          Text(
                            context
                                        .watch<
                                            FormRequestPengangkatanProvider>()
                                        .selectedDate !=
                                    null
                                ? getStringDate(context
                                    .watch<FormRequestPengangkatanProvider>()
                                    .selectedDate)
                                : "Tanggal",
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: hexToColor("#CBCBCB"))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                          ),
                          Container(
                            width: 12,
                          ),
                          Text(
                            context
                                        .watch<
                                            FormRequestPengangkatanProvider>()
                                        .selectedTime !=
                                    null
                                ? getStringTime(context
                                    .watch<FormRequestPengangkatanProvider>()
                                    .selectedTime)
                                : "Jam",
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getStringDate(DateTime selectedDate) {
    return "${selectedDate.day} ${getMonth(selectedDate.month)}";
  }

  getStringTime(TimeOfDay selectedTime) {
    final now = new DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    return DateFormat("HH:mm").format(dt);
  }
}
