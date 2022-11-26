import 'dart:core';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';
import 'package:intl/intl.dart';


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


class DateStates{
  late List<DateState> dateStates;

/*  static List<DateState> generateOperations(List<TimeOfDay> hours){
    List<DateState> operations=[];
    for( var time in hours ) {
      operations.add(DateState(time,0));
    }

    return operations;
  }*/
  List<TimeOfDay> getMyReservationsOnDay(DateTime date){
    List<TimeOfDay> reservations=[];
    for (var dateState in dateStates)
    {
      TimeOfDay time = TimeOfDay(hour: dateState.time.hour, minute: dateState.time.minute);
      reservations.add(time);
    }
    return reservations;
  }

  List<DateState> getDateStatesAt(DateTime date)
  {
    return [];
  }

  List<TimeOfDay> getAvailableHours(DateTime date) {
    List<TimeOfDay> hours = [];
    int time = 8;

    var step = 30;
    var startHour = 7;

    for(var i=startHour*60;i<24*60+startHour*60;i+=step)
    {
      hours.add(TimeOfDay(hour: (i/60).floor()%24, minute: i%60));
    }
    ///////////
    List<DateState> currentDateStates = getDateStatesAt(date);
    //TODO: ESTA HARDCODED
    return hours;
/*    if (currentDateStates.isNotEmpty)
    {
      for(var i=startHour*60;i<24*60+startHour*60;i+=step)
      {
        var hour = DateTime(date.year,date.month,date.day, (i/60).floor()%24, i%60);
        if(!currentDateStates.contains(hour) || currentDateStates[currentDateStates.indexOf(hour)].type==1)
        {
          availableHours.add(TimeOfDay(hour: hour.hour, minute: hour.minute));
        }
      }
    }
    return availableHours;*/
  }

  static List<DateState> generateStates(List<DateTime> reservations, List<DateTime> blocked){
    List<DateState> dateStates=[];
    for( var date in reservations ) {
      dateStates.add(DateState(date,0));
    }
    for( var date in blocked ) {
      dateStates.add(DateState(date,-1));
    }

    return dateStates;
  }

  static List<TimeOfDay> getHours(List<DateState> dateStates){
    List<TimeOfDay> hours=[];
    for( DateState dateState in dateStates ) {
      hours.add(TimeOfDay(hour: dateState.time.hour, minute: dateState.time.minute));
    }

    return hours;
  }

  DateStates(List<DateTime> reservations, List<DateTime> blocked ){
    dateStates = DateStates.generateStates(reservations, blocked);
    log(dateStates.toString());
  }



}

class DateState{
  late DateTime time;
  late int type;
  // constructor
  DateState(this.time, this.type);
}


class bookingCalendar extends StatefulWidget {
  int id;
  late DateTime selectedDate;
  late DateStates datesState;
  bookingCalendar({Key? key, required this.id}) : super(key: key);

  @override
  State<bookingCalendar> createState() => _bookingCalendarState();
}

class _bookingCalendarState extends State<bookingCalendar> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          customCalendar(get_selected_date: getDate),
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
                      DateFormat('yyyy-MM-dd').format(widget.selectedDate) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())?
                      "Hoy":
                      DateFormat('dd · MM · yyyy').format(widget.selectedDate).toString(),
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
          hourList(myReservations: widget.datesState.getMyReservationsOnDay(widget.selectedDate).toSet(),
                  availableHours: widget.datesState.getAvailableHours(widget.selectedDate).toSet(),
                  update_hours_availability: getMyReservations,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: ElevatedButton(

              onPressed: (){
                makeReservations();
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

  //////////////////////--FUNCTIONS--///////////////////////
  List getHourAvailabilityFromBackend() {

    return [];
  }
//CALLBACKS
  //callbacks custom_calendar
  void getDate(DateTime date){
    setState(() {
      widget.selectedDate = date;
      log("dia seleccionado: $date");
    });
  }

  //callbacks hour list
  void getMyReservations()
  {

  }

 /////////////////////////

  void initDateState(){
    var now = DateTime.now();
    List<DateTime> bloquedDates = [];
    List<DateTime> myReservedDates =  [DateTime(now.year,now.month,now.day,now.hour,now.minute),DateTime(now.year,now.month,now.day,now.hour,now.minute+30),DateTime(now.year,now.month,now.day,now.hour+1,now.minute),];//PublicationService.getBlockedHoursByDay(widget.selectedDate);
    log("ejecutando init--------------");
    widget.datesState = DateStates(myReservedDates, bloquedDates);
  }

  @override
  void initState() {
    var now = DateTime.now();
    widget.selectedDate = DateTime(now.year,now.month,now.day);
    initDateState();

    super.initState();
  }

  void makeReservations(){

  }
}

