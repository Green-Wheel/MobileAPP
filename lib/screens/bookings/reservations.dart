import 'dart:core';
import 'package:flutter/material.dart';
import '../../widgets/booking_calendar.dart';



void main() => runApp(Reservate(id: 1));

//TODO: exportar colores a clase
class Reservate extends StatelessWidget {
  int id;
  Reservate({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: bookingCalendar(id: 1),
    );
  }
}