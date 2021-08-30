import 'package:json_annotation/json_annotation.dart';

enum Month {
  @JsonValue(1)
  january,
  @JsonValue(2)
  february,
  @JsonValue(3)
  march,
  @JsonValue(4)
  april,
  @JsonValue(5)
  may,
  @JsonValue(6)
  june,
  @JsonValue(7)
  july,
  @JsonValue(8)
  august,
  @JsonValue(9)
  september,
  @JsonValue(10)
  october,
  @JsonValue(11)
  november,
  @JsonValue(12)
  december
}

const List<Month> trashiMonths = [
  Month.january,
  Month.february,
  Month.march,
  Month.april,
  Month.may,
  Month.june,
  Month.july,
  Month.august,
  Month.september,
  Month.october,
  Month.november,
  Month.december
];

extension MonthExtension on Month {
  String get locale {
    switch (this) {
      case Month.january:
        return 'Januari';
      case Month.february:
        return 'Februari';
      case Month.march:
        return 'Maret';
      case Month.april:
        return 'April';
      case Month.may:
        return 'Mei';
      case Month.june:
        return 'Juni';
      case Month.july:
        return 'Juli';
      case Month.august:
        return 'Agustus';
      case Month.september:
        return 'September';
      case Month.october:
        return 'Oktober';
      case Month.november:
        return 'November';
      case Month.december:
        return 'Desember';
    }

    return '';
  }

  int get inNumber {
    switch (this) {
      case Month.january:
        return 1;
      case Month.february:
        return 2;
      case Month.march:
        return 3;
      case Month.april:
        return 4;
      case Month.may:
        return 5;
      case Month.june:
        return 6;
      case Month.july:
        return 7;
      case Month.august:
        return 8;
      case Month.september:
        return 9;
      case Month.october:
        return 10;
      case Month.november:
        return 11;
      case Month.december:
        return 12;
    }

    return 0;
  }

  String get abbreviatedLocale {
    switch (this) {
      case Month.january:
        return 'Jan';
      case Month.february:
        return 'Feb';
      case Month.march:
        return 'Mar';
      case Month.april:
        return 'Apr';
      case Month.may:
        return 'Mei';
      case Month.june:
        return 'Jun';
      case Month.july:
        return 'Jul';
      case Month.august:
        return 'Agu';
      case Month.september:
        return 'Sep';
      case Month.october:
        return 'Okt';
      case Month.november:
        return 'Nov';
      case Month.december:
        return 'Des';
    }

    return '';
  }
}

getMonthText(int month) {
  switch (month) {
    case 1:
      return 'Januari';
    case 2:
      return 'Februari';
    case 3:
      return 'Maret';
    case 4:
      return 'April';
    case 5:
      return 'Mei';
    case 6:
      return 'Juni';
    case 7:
      return 'Juli';
    case 8:
      return 'Agustus';
    case 9:
      return 'September';
    case 10:
      return 'Oktober';
    case 11:
      return 'November';
    case 12:
      return 'Desember';
  }

  return '';
}

getMonthTextFromString(String month) {
  switch (month) {
    case '01':
      return 'Januari';
    case '02':
      return 'Februari';
    case '03':
      return 'Maret';
    case '04':
      return 'April';
    case '05':
      return 'Mei';
    case '06':
      return 'Juni';
    case '07':
      return 'Juli';
    case '08':
      return 'Agustus';
    case '09':
      return 'September';
    case '10':
      return 'Oktober';
    case '11':
      return 'November';
    case '12':
      return 'Desember';
  }

  return '';
}
