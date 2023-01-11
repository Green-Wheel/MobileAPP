import 'package:flutter/material.dart';

class Config{
  static Duration minTimeOfReservation = const Duration(minutes: 30);
  static TimeOfDay hourListFirstHour = const TimeOfDay(hour: 7, minute: 0);
  static TimeOfDay startingHour = const TimeOfDay(hour: 0, minute: 0);
  static TimeOfDay endingHour = const TimeOfDay(hour: 23, minute: 59);
}