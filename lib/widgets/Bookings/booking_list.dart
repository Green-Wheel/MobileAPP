

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:greenwheel/widgets/Bookings/booking_calendar.dart';
import 'package:greenwheel/widgets/Bookings/utils/stringOverflow.dart';
import 'package:intl/intl.dart';
import 'package:greenwheel/services/backendServices/bookings.dart';
import '../../../serializers/bookings.dart' as bkn;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:developer';
void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();


    return MaterialApp(
      title: 'Confirm booking',
      home: booking_list(getFinisheds:true,isOwner: true,),
    );
  }
}

class booking_list extends StatefulWidget {
  List<bkn.Booking> bookings=[];
  bool waitingBackend = true;
  bool getFinisheds=true;

  var isOwner;
  booking_list({Key? key,required this.getFinisheds, required this.isOwner}) : super(key: key);

  @override
  State<booking_list> createState() => _booking_listState();
}

class _booking_listState extends State<booking_list> {


  Future<void> getPastBookingsFromBackend() async {

    widget.waitingBackend = true;
    widget.bookings = (await BookingService.getBookingsHistory(widget.isOwner)).cast<bkn.Booking>();

    log("#################### PASADAS #####################");
    log(widget.bookings.toString());
    widget.waitingBackend = false;
    setState(() {

    });
  }

  Future<void> getNotFinishedBookingsFromBackend() async {

    widget.waitingBackend = true;
    widget.bookings = (await BookingService.getBookingsByType("not_finished", widget.isOwner)).cast<bkn.Booking>();
    log("#################### PENDIENTES #####################");    log(widget.bookings.toString());
    widget.waitingBackend = false;
    setState(() {

    });
  }

  @override
  void initState() {

    (widget.getFinisheds)?
    getPastBookingsFromBackend():
    getNotFinishedBookingsFromBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widget.waitingBackend && widget.bookings.length <= 0)?
      Container(
        decoration: const BoxDecoration(
            color: Colors.white70
        ),
        child: Center(
          child:  LoadingAnimationWidget.discreteCircle(
              color: Colors.green.shade50,
              size: 70,
              secondRingColor: Colors.green.shade200,
              thirdRingColor: Color(0x10052e42)),
        ),
      ):
      Container(

        child: (widget.bookings.length <= 0 )?
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child:
          const Text(
            "No hay reservas pasadas",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45
            ),),
        ):
        Column(
          children: [
            /*Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xF0052e42)
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        "Historial de reservas al punto",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            Expanded(
              child: ListView.builder(
                itemCount: widget.bookings.length,
                itemBuilder: (BuildContext context, int index) {
                  bkn.Booking booking = widget.bookings[index];
                  return Card(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: Colors.blueGrey.shade50),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "INICIO",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Color(0xA0052e42)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (booking.publication.type== "Charger")?
                                      cutDownString(booking.publication.charger?.title ?? 'Sin título') :
                                      cutDownString(booking.publication.bike?.title  ?? 'Sin títutlo'),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.green),
                                    ),
                                    (booking.publication.type== "Charger")?
                                    Icon(Icons.bolt,color: Colors.green,):
                                    Icon(Icons.directions_bike,color: Colors.green,),
                                  ],
                                ),
                                Text(
                                  "FIN",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color(0xA0052e42)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_month, color: Color(0xF0052e42),),
                                        Text(' ${DateFormat('yyyy·MM·dd').format(booking.start_date)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, color: Color(0xF0052e42)),
                                        Text(' ${DateFormat('kk:mm').format(booking.start_date)} h'),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_circle_right,color: Colors.blue.shade200,size: 35,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_month,color: Color(0xF0052e42)),
                                        Text(' ${DateFormat('yyyy·MM·dd').format(booking.end_date)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time,color: Color(0xF0052e42),                                                                ),
                                        Text(' ${DateFormat('kk:mm').format(booking.end_date)} h',),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              if(widget.getFinisheds && !widget.isOwner)...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blueGrey.shade50,  // red as border color
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          OutlinedButton(
                                              onPressed: (){},
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.redAccent,
                                                  backgroundColor: Colors.white,
                                                  side: BorderSide(width: 1.0, color: Colors.redAccent),

                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.report_outlined,color: Colors.redAccent,size: 18,),
                                                  Text(" Reportar"),
                                                ],
                                              )),
                                          OutlinedButton(
                                              onPressed: (){},
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(width: 1.0, color: Colors.blue),

                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.rate_review,color: Colors.blue, size: 18,),
                                                  Text(" Valorar"),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )],
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50
                                ),
                                child: Column(
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            if(booking.status.name == "Confirmed")...[
                                              const Icon(Icons.check, color: Color(0xf0052e42),),
                                              const Text(' Confirmada')
                                            ]
                                           else if(booking.status.name == "Cancelled")...[
                                              const Icon(Icons.check, color: Color(0xf0052e42),),
                                              const Text(' Cancelada')
                                            ]
                                            else if(booking.status.name == "Pending")...[
                                              const Icon(Icons.pending, color: Color(0xf0052e42),),
                                              const Text(' Pendiente')
                                            ]
                                            else if(booking.status.name == "Denied")...[
                                              const Icon(Icons.block, color: Color(0xf0052e42),),
                                              const Text(' Denegada')
                                            ]


                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            Icon(Icons.person, color: Color(0xf0052e42),),
                                            Text(' ${booking.user.username}'),
                                          ],
                                        ),

                                      ],
                                    ),

                                  ],
                                ),

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



