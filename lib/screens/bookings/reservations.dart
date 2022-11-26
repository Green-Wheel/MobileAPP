import 'dart:core';
import 'package:flutter/material.dart';
import '../../widgets/booking_calendar.dart';



void main() => runApp(MyApp());

//TODO: exportar colores a clase
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: bookingCalendar(id: 1),
    );
  }
}