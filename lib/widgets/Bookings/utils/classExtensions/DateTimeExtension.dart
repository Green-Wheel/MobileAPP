import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DatetimeExtension on DateTime {
  TimeOfDay toTimeOfDay(){
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool isToday(){
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now) ==
        DateFormat('yyyy-MM-dd').format(this);
  }

  bool hasPast(){
    DateTime now = DateTime.now();
    if(now.day == day && now.month==month && now.year == year) return false;
    return this < now;
  }

  bool isTomorrow(){
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now) ==
        DateFormat('yyyy-MM-dd').format(subtract(const Duration(days:1)));
  }

  bool operator >= (DateTime b)
  {
    return compareTo(b) == 1 || compareTo(b) == 0;
  }

  bool operator <= (DateTime b)
  {
    return compareTo(b) == -1 || compareTo(b) == 0;
  }

  bool operator > (DateTime b)
  {
    return compareTo(b) == 1;
  }

  bool operator < (DateTime b)
  {
    return compareTo(b) == -1;
  }
}
