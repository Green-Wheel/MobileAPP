import 'dart:async';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';
import 'package:intl/intl.dart';
import 'lib/services/backendServices/publications.dart';

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
  Map<DateTime, List<TimeOfDay>> selectedDates = {};
  List<TimeOfDay> myReservations=[];
  List<TimeOfDay> availableHours=[];

  @override
  void initState() {
    log(availableHours.toString());
    log(myReservations.toString());
    getHourAvailability_backend(selectedDate);
    super.initState();
  }

  void split_reservations(){

    selectedDates.forEach((key, value) {


    });
  }

  void make_reservations() {
    split_reservations();

  }

  void getDate(DateTime date){
    setState(() {
      selectedDate = date;
      if (selectedDates.containsKey(selectedDate))
        myReservations = selectedDates[selectedDate]!;
      else{
        log("seborra");
        log(selectedDates.toString());
        getHourAvailability_backend(date);
      }

      log("dia seleccionado: $date");
    });
  }

  void getHourAvailability_backend(date){
    log("yvaamosss al backeeend");

    setState(() {
      selectedDate = date;
      myReservations = [TimeOfDay(hour:8 ,minute: 0)];
      availableHours = [TimeOfDay(hour:8 ,minute: 30),TimeOfDay(hour:10 ,minute: 88),TimeOfDay(hour:1 ,minute: 30),TimeOfDay(hour: 2,minute: 0),TimeOfDay(hour:2 ,minute: 30),TimeOfDay(hour: 3, minute: 30),];

      log(date.toString());
    });
  }

  void getHourAvailability(List<TimeOfDay> myReservations){
    setState(() {
      this.myReservations = myReservations;
      this.myReservations.sort((a,b) => a.compareTo(b));

      selectedDates[selectedDate]=this.myReservations;
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
          hourList(myReservations: myReservations.toSet(), availableHours: availableHours.toSet(), update_hours_availability: getHourAvailability,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: ElevatedButton(

              onPressed: (){
                make_reservations();
              },

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