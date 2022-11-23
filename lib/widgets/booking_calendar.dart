import 'dart:async';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';

void main() => runApp(MyApp());

//TODO: exportar colores a clase
//TODO:
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Booking calendar',
      home: bookingCalendar(),
    );
  }
}

class bookingCalendar extends StatefulWidget {
  const bookingCalendar({Key? key}) : super(key: key);


  @override
  _bookingCalendarState createState() => _bookingCalendarState();
}

class _bookingCalendarState extends State<bookingCalendar> {
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Map<DateTime, Set<TimeOfDay>> selectedDates = {};
  Set<TimeOfDay> myReservations = {TimeOfDay(hour:1 ,minute: 0)};
  Set<TimeOfDay> availableHours = {TimeOfDay(hour:1 ,minute: 0),TimeOfDay(hour:88 ,minute: 88),TimeOfDay(hour:1 ,minute: 30),TimeOfDay(hour: 2,minute: 0),TimeOfDay(hour:2 ,minute: 30),TimeOfDay(hour: 3, minute: 30),};

  @override
  void initState() {
    log(availableHours.toString());
    log(myReservations.toString());
    selectedDates[selectedDate]=myReservations;
    super.initState();
  }

  void getDate(DateTime date){
    setState(() {
      selectedDate = date;
      if (selectedDates.containsKey(selectedDate))
        myReservations = selectedDates[selectedDate]!;
      else{
        log("seborra");
        log(selectedDates.toString());
        myReservations = {};
      }

      log("dia seleccionado: $date");
    });
  }

  void getHourAvailability_backend(date){
    setState(() {
      selectedDate = date;
      myReservations = {};
      log(date.toString());
    });
  }

  void getHourAvailability(Set<TimeOfDay> myReservations, Set<TimeOfDay> availableHours){
    setState(() {
      this.myReservations = myReservations;
      this.availableHours = availableHours;

      selectedDates[selectedDate]=myReservations;
      log("Cambios en myReservations");
      log(selectedDates.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          customCalendar(get_selected_date: getDate,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(0, 10),
              ),
            ],
              color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Horas disponibles:",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())?
                      "Hoy":
                      DateFormat('dd · MM · yyyy').format(selectedDate).toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          hourList(myReservations: myReservations, availableHours: availableHours, update_hours_availability: getHourAvailability,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: ElevatedButton(

              onPressed: (){},

              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width*1, 50),
                maximumSize: Size(MediaQuery.of(context).size.width*1, double.infinity),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                      width: 2,
                      color: Colors.green.shade800
                  )
                  ),
                backgroundColor:  Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Reservar ",
                    style: TextStyle(
                      fontSize: 22
                    ),

                  ),
                  Icon(Icons.event_available,size: 25,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}