import 'dart:core';
import 'dart:developer';
import 'package:greenwheel/services/backendServices/bookings.dart';
import 'package:greenwheel/services/backendServices/publications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';

void main() => runApp(const MyApp());

//TODO: exportar colores a clase
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: bookingCalendar(id: 1),
    );
  }
}


class bookingCalendar extends StatefulWidget {
  int id;
  bookingCalendar({Key? key,required this.id}) : super(key: key);

  @override
  _bookingCalendarState createState() => _bookingCalendarState();
}

class Reservation{
  late DateTime startDate;
  late DateTime end_date;

  @override
  String toString(){
    return "Reserva: "+startDate.toString()+" ->"+end_date.toString()+"\n";
  }

  Reservation(this.startDate, this.end_date);
}

class Modification{
  late DateTime start_date;
  late int type;
}

class _bookingCalendarState extends State<bookingCalendar> {
  Map<String, dynamic> data = Map();
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
    data['id'] = widget.id;
    super.initState();
  }


  bool are_contiguous(DateTime d1,DateTime d2){
    String as="Si ";
    if (d1.difference(d2).inMinutes.abs() <= 30)
      as = "No ";

    log(as+"son contiguos---> ${d1} | ${d2} difference ${d1.difference(d2).inMinutes}");
    return d1.difference(d2).inMinutes.abs() <= 30;
  }

  List<Reservation> split_reservations(){
    List<Reservation> reservations = [];
    DateTime firstDate = selectedDates.keys.toList().first;
    TimeOfDay firstHour = selectedDates[firstDate]!.first;
    DateTime start = DateTime(firstDate.year,firstDate.month,firstDate.day,
        firstHour.hour,firstHour.minute);
    DateTime last = DateTime(firstDate.year,firstDate.month,firstDate.day,
        firstHour.hour,firstHour.minute);

    if(selectedDates.isNotEmpty)
    {
      selectedDates.forEach((date, hours) {
        for(var hour in hours){
          DateTime currentDate = DateTime(date.year,date.month,date.day,
              hour.hour, hour.minute);
          if(!are_contiguous(last,currentDate)){
            DateTime end = DateTime(date.year, date.month, date.day, last.hour, last.minute+29);
            reservations.add(Reservation(start, end));
            start = currentDate;
          }
          last = currentDate;
        }
      });
      DateTime end = DateTime(last.year, last.month, last.day, last.hour, last.minute+29);
      reservations.add(Reservation(start, end));
    }
    log("LAS RESERVAS:");
    log(reservations.toString());
    return reservations;

  }

  void make_reservations() {
    if(selectedDates.isEmpty) return;
    selectedDates = Map.fromEntries(
        selectedDates.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    log("Making reservations");
    log(selectedDates.toString());
    List<Reservation> reservations = split_reservations();
    for(var reservation in reservations){
      data['startdate'] = reservation.startDate;
      data['enddate'] = reservation.end_date;
      //TODO: PONER MENSAJE DE ALERTA SI FALLA
      BookingService.newBooking(data);
    }
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
      myReservations = [TimeOfDay(hour:8 ,minute: 30)];
      availableHours = [TimeOfDay(hour:8 ,minute: 30),TimeOfDay(hour:10 ,minute: 88),TimeOfDay(hour:1 ,minute: 30),TimeOfDay(hour:1 ,minute: 0),TimeOfDay(hour:0 ,minute: 30),TimeOfDay(hour: 2,minute: 0),TimeOfDay(hour:4,minute: 30),TimeOfDay(hour: 3, minute: 30),];
      data['year'] = date.year;
      data['month'] = date.month;
      data['day'] = date.day;

      PublicationService.getBlockedHoursByDay(data);
      log(date.toString());
    });
  }

  void getHourAvailability(List<TimeOfDay> myReservations){
    setState(() {
      this.myReservations = myReservations;
      //this.myReservations.sort((a,b) => a.compareTo(b));

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
          //hourList(reservations: myReservations.toSet(), blockedHours: availableHours.toSet(), return_change_in_reservations: getHourAvailability,),

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