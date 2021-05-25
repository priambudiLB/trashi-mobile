import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/utils/commons.dart';

class DatePickerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate:
              context.read<FormRequestPengangkatanProvider>().selectedDate !=
                      null
                  ? context.read<FormRequestPengangkatanProvider>().selectedDate
                  : DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(2101));
      if (picked != null &&
          picked !=
              context.read<FormRequestPengangkatanProvider>().selectedDate) {
        context.read<FormRequestPengangkatanProvider>().setSelectedDate(picked);
      }
    }

    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: hexToColor("#CBCBCB"))),
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
              context.watch<FormRequestPengangkatanProvider>().selectedDate !=
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
    );
  }

  getStringDate(DateTime selectedDate) {
    return "${selectedDate.day} ${getMonth(selectedDate.month)}";
  }
}
