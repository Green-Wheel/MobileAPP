import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  DateTime toDateTime(date){
    return DateTime( date.year, date.month, date.day, hour, minute);
  }

  int compareTo(TimeOfDay b) {
    if (hour < b.hour) return -1;
    if (hour > b.hour) return 1;
    if (minute <  b.minute) return -1;
    if (minute > b.minute) return 1;
    return 0;
  }

  bool operator >= (TimeOfDay b)
  {
    return compareTo(b) == 1 || compareTo(b) == 0;
  }

  bool operator <= (TimeOfDay b)
  {
    return compareTo(b) == -1 || compareTo(b) == 0;
  }

  bool operator > (TimeOfDay b)
  {
    return compareTo(b) == 1;
  }

  bool operator < (TimeOfDay b)
  {
    return compareTo(b) == -1;
  }
}

