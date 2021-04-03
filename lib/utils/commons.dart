import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const int FIGMA_HEIGHT = 640;
const int FIGMA_WIDTH = 480;
const int COLOR_STARTING_HEX = 0xFF000000;

const Map<String, String> MONTH_MAP = {
  "01": "Januari",
  "02": "Februari",
  "03": "Maret",
  "04": "April",
  "05": "Mei",
  "06": "Juni",
  "07": "Juli",
  "08": "Agustus",
  "09": "September",
  "10": "Oktober",
  "11": "November",
  "12": "Desember",
};

String getMonth(int monthNumber) {
  List<String> monthList = MONTH_MAP.values.toList();
  return monthList[monthNumber - 1];
}

Color hexToColor(String hexColorCode) {
  return new Color(
      int.parse(hexColorCode.substring(1, 7), radix: 16) + COLOR_STARTING_HEX);
}

double fitScreenSize(double main, double unit) {
  return main * unit;
}

double fitFigmaScaleHeight(double main, BuildContext context) {
  return fitScreenSize(main / FIGMA_HEIGHT, MediaQuery.of(context).size.width);
}

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
  ));
}

bool isSameMonth(String currentMonth, String givenMonth) {
  return "${currentMonth.split("-")[0]}-${currentMonth.split("-")[1]}" ==
      "${givenMonth.split("-")[0]}-${givenMonth.split("-")[1]}";
}

bool isSameYear(String currentYear, String givenYear) {
  return currentYear.split("-")[0] == givenYear.split("-")[0];
}

String getBeginningOfMonthDateString(DateTime dateTime) {
  return "${dateTime.toString().split(" ")[0].split("-")[0]}-${dateTime.toString().split(" ")[0].split("-")[1]}-01";
}

String getFormattedMonthString(DateTime dateTime) {
  return "${getMonth(int.parse(dateTime.toString().split(" ")[0].split("-")[1]))} ${dateTime.toString().split(" ")[0].split("-")[0]}";
}

String getFormattedDayString(DateTime dateTime) {
  return "${int.parse(dateTime.toString().split(" ")[0].split("-")[2])} ${getMonth(int.parse(dateTime.toString().split(" ")[0].split("-")[1]))} ${dateTime.toString().split(" ")[0].split("-")[0]}";
}

DateTime addOneMonthFromCurrentDate(DateTime dateTime) {
  String beginningOfMonthDateString = getBeginningOfMonthDateString(dateTime);
  int addedMonth = int.parse(beginningOfMonthDateString.split("-")[1]) + 1;
  String formattedNextMonth = addedMonth < 10
      ? "${beginningOfMonthDateString.split("-")[0]}-0$addedMonth-01"
      : "${beginningOfMonthDateString.split("-")[0]}-$addedMonth-01";

  return DateTime.parse(formattedNextMonth);
}

DateTime subtractOneMonthFromCurrentDate(DateTime dateTime) {
  String beginningOfMonthDateString = getBeginningOfMonthDateString(dateTime);
  int subtractedMonth = int.parse(beginningOfMonthDateString.split("-")[1]) - 1;
  String formattedNextMonth = subtractedMonth < 10
      ? "${beginningOfMonthDateString.split("-")[0]}-0$subtractedMonth-01"
      : "${beginningOfMonthDateString.split("-")[0]}-$subtractedMonth-01";

  return DateTime.parse(formattedNextMonth);
}

Map<dynamic, dynamic> reverseMap(Map<dynamic, dynamic> inputMap) {
  Map<dynamic, dynamic> result;
  for (int i = 0; i < inputMap.length; i++) {
    dynamic x = inputMap.entries.last.key;
    dynamic y = inputMap.entries.last.value;
    result[x] = y;
    inputMap.remove(x);
  }

  return result;
}
