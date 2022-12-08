import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:greenwheel/widgets/booking_calendar2.dart';

class hourList extends StatefulWidget {
  var reservations;
  var blockedHours;
  final Function return_change_in_reservations;
  hourList({Key? key,required this.reservations,
    required this.blockedHours, required this.return_change_in_reservations}) : super(key: key);

  @override
  _hourListState createState() => _hourListState();
}


//TODO: exportat generacion de hours a booking_calendar
class _hourListState extends State<hourList> {
  List<TimeOfDay> hours = [];
  int time = 8;

  @override
  void initState() {
    var step = 30;
    var startHour = DateTime.now().hour;

    var now = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    //se puede mejorar importando funcionalidades de timeofday y datetime de booking_calendar2
    for(var i=startHour*60;i<24*60+startHour*60;i+=step)
    {
      var hour = TimeOfDay(hour: (i/60).floor()%24, minute: i%60);
      //se puede mejorar importando funcionalidades de timeofday y datetime de booking_calendar2

      if(hour.compareTo(TimeOfDay(hour: now.hour, minute: now.minute)) >= 0){
        hours.add(hour);
      }

    }

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

    return Expanded(
      child: Container(
        color: Colors.white,
        child: GridView.builder(
          padding: EdgeInsets.all(1),
          physics: ScrollPhysics(),
          shrinkWrap: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
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
                    Operation operation = Operation.delete;
                    if(!widget.reservations.remove(time) && !widget.blockedHours.contains(time)) {
                      widget.reservations.add(time);
                      widget.reservations.toString();
                      operation = Operation.add;
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
                      side: BorderSide(width:1.5,color: !widget.blockedHours.contains(time)? Colors.green: Colors.black45)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    //se puede mejorar importando las funcionalidades de timeofday y datetime de booking-calendar2
                    "${DateFormat("HH:mm").format(DateTime(2000,1,1, time.hour, time.minute))} ",
                    style: TextStyle(
                      fontSize: 12,
                      color: !widget.blockedHours.contains(time)? widget.reservations.contains(time)? Colors.white: Colors.green: Colors.blueGrey,
                    ),
                  ),
                  !widget.blockedHours.contains(time)? widget.reservations.contains(time)?  Icon(Icons.check_circle_rounded, color: Colors.white, size: 14,): Icon(Icons.schedule, color: Colors.green, size: 14,):
                  Icon(Icons.lock, color: Colors.blueGrey, size: 14,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}