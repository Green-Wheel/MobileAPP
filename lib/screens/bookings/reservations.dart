import 'dart:core';
import 'package:flutter/material.dart';
import '../../widgets/Bookings/booking_calendar.dart';


//TODO: exportar colores a clase
class Reservate extends StatelessWidget {
  int id;
  Reservate({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: BookingCalendar(id: id),
    );
  }
}