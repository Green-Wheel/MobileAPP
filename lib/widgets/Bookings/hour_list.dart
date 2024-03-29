import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:greenwheel/widgets/Bookings/booking_calendar.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/TimeOfDayExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/enums.dart';

class hourList extends StatefulWidget {
  late bool showHoursStartingAtCurrentHour;
  var reservations;
  var blockedHours;
  final Function return_change_in_reservations;
  hourList({Key? key,required this.showHoursStartingAtCurrentHour,required this.reservations,
    required this.blockedHours, required this.return_change_in_reservations}) : super(key: key);

  @override
  _hourListState createState() => _hourListState();
}


//TODO: exportat generacion de hours a booking_calendar
class _hourListState extends State<hourList> {
  List<TimeOfDay> hours = [];
  int time = 8;



  void initHours(){
    hours = [];
    var step = 30;
    var startHour = widget.showHoursStartingAtCurrentHour? DateTime.now().hour: 0;
    //log("**************************************${widget.showHoursStartingAtCurrentHour}");
    var now = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    //se puede mejorar importando funcionalidades de timeofday y datetime de booking_calendar2
    for(var i=startHour*60;i<24*60+startHour*60;i+=step)
    {
      var hour = TimeOfDay(hour: (i/60).floor()%24, minute: i%60);
      //se puede mejorar importando funcionalidades de timeofday y datetime de booking_calendar2

      if(hour.compareTo(TimeOfDay(hour: now.hour, minute: now.minute)) >= 0 ||
          !widget.showHoursStartingAtCurrentHour){
        hours.add(hour);
      }
    }
  }

  @override
  void initState() {
    initHours();

    super.initState();
  }

/*
  List<TimeOfDay> orderHours(List<TimeOfDay> myReservations){
    List<TimeOfDay> res = myReservations.toList();
    res.sort((a,b) => a.compareTo(b));
    return res;
  }
*/

  @override
  Widget build(BuildContext context) {
    initHours();

    return (hours.isEmpty)?
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("No hay horas disponibles"),
            ))
        :Expanded(
      child: Container(
        color: Colors.white,
        child: GridView.builder(
          padding: EdgeInsets.all(2),
          physics: ScrollPhysics(),
          shrinkWrap: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: hours.length,
          itemBuilder: (context, id) {
            var time = hours[id];
            return ElevatedButton(
              onPressed: (){
                setState(() {

                  if(!widget.blockedHours.contains(time)) {
                    OperationType operation = OperationType.delete;
                    if(!widget.reservations.remove(time) && !widget.blockedHours.contains(time)) {
                      widget.reservations.add(time);
                      widget.reservations.toString();
                      operation = OperationType.add;
                    }
                    widget.return_change_in_reservations(time,operation);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  backgroundColor: !widget.blockedHours.contains(time)? widget.reservations.contains(time)? Colors.green : Colors.white : Colors.blueGrey.shade100,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(width:1.5,color: !widget.blockedHours.contains(time)? widget.reservations.contains(time)? Colors.green :Colors.green.shade100: Colors.black45)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    //se puede mejorar importando las funcionalidades de timeofday y datetime de booking-calendar2
                    "${DateFormat("HH:mm").format(DateTime(2000,1,1, time.hour, time.minute))} ",
                    style: TextStyle(
                      fontSize: 14,
                      color: !widget.blockedHours.contains(time)? widget.reservations.contains(time)? Colors.white: Colors.green: Colors.blueGrey,
                    ),
                  ),
                  !widget.blockedHours.contains(time)? widget.reservations.contains(time)?  Icon(Icons.check_circle_rounded, color: Colors.white, size: 14,): Icon(Icons.schedule, color: Colors.green, size: 14,):
                  Icon(Icons.lock, color: Colors.blueGrey, size: 16,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}