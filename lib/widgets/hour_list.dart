import 'dart:async';

import 'dart:developer';

import 'package:flutter/material.dart';


class hourList extends StatefulWidget {
  var myReservations;
  var availableHours;
  final Function update_hours_availability;
  hourList({Key? key,required this.myReservations,
            required this.availableHours, required this.update_hours_availability}) : super(key: key);

  @override
  _hourListState createState() => _hourListState();
}

class _hourListState extends State<hourList> {
  List<TimeOfDay> hours = [];
  int time = 8;

  @override
  void initState() {
    // TODO: implement initState
    var step = 30;
    var startHour = 7;
    for(var i=startHour*60;i<24*60+startHour*60;i+=step)
    {
      this.hours.add(TimeOfDay(hour: (i/60).floor()%24, minute: i%60));
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        color: Colors.white,
        child: GridView.builder(
          padding: EdgeInsets.all(2),
          physics: ScrollPhysics(),
          shrinkWrap: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  if(!widget.myReservations.remove(time) && widget.availableHours.contains(time))
                  {
                      widget.myReservations.add(time);
                      widget.myReservations.toString();
                  }
                  widget.update_hours_availability(widget.myReservations,widget.availableHours);
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                backgroundColor: widget.availableHours.contains(time)? widget.myReservations.contains(time)? Colors.green : Colors.white : Colors.blueGrey.shade100,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                shape:
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(width:1.5,color: widget.availableHours.contains(time)? Colors.green: Colors.black45)
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "${time.hour}:${time.minute} ",
                    style: TextStyle(
                      fontSize: 17,
                      color: widget.availableHours.contains(time)? widget.myReservations.contains(time)? Colors.white: Colors.green: Colors.blueGrey,
                    ),
                  ),
                  widget.availableHours.contains(time)? widget.myReservations.contains(time)?  Icon(Icons.check_circle_rounded, color: Colors.white, size: 18,): Icon(Icons.schedule, color: Colors.green, size: 18,):
                  Icon(Icons.lock, color: Colors.blueGrey, size: 18,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}