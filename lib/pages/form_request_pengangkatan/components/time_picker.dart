import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/time_type.dart';
import 'package:trashi/utils/commons.dart';

class TimePickerComponent extends StatelessWidget {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime:
            context.read<FormRequestPengangkatanProvider>().selectedTime != null
                ? context.read<FormRequestPengangkatanProvider>().selectedTime
                : TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    if (picked != null &&
        picked !=
            context.read<FormRequestPengangkatanProvider>().selectedTime) {
      context.read<FormRequestPengangkatanProvider>().setSelectedTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<FormRequestPengangkatanProvider>().selectedTimeType ==
            TimeType.SCHEDULED_TIME) {
          _selectTime(context);
        }
      },
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: hexToColor("#CBCBCB")),
            color: context
                        .watch<FormRequestPengangkatanProvider>()
                        .selectedTimeType ==
                    TimeType.NOW
                ? Colors.grey[200]
                : Colors.transparent),
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 14,
              color: hexToColor("#C4C4C4"),
            ),
            Container(
              width: 12,
            ),
            context.watch<FormRequestPengangkatanProvider>().selectedTime !=
                    null
                ? Text(
                    getStringTime(context
                        .watch<FormRequestPengangkatanProvider>()
                        .selectedTime),
                  )
                : Text(
                    "Jam",
                    style: TextStyle(color: hexToColor("#C4C4C4")),
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

  getStringTime(TimeOfDay selectedTime) {
    final now = new DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    return DateFormat("HH:mm").format(dt);
  }
}
