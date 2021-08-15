enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
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
}
