import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:greenwheel/widgets/Bookings/booking_calendar.dart';
import 'package:intl/intl.dart';
import 'package:greenwheel/services/backendServices/bookings.dart';
import '../../../serializers/bookings.dart' as bkn;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:developer';

import 'configs/confirm_bookings_config.dart';

void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();


    return MaterialApp(
      title: 'Confirm booking',
      home: confirm_booking(),
    );
  }
}

class confirm_booking extends StatefulWidget {
  List<bkn.Booking> bookings=[];
  bool waitingBackend = true;


  confirm_booking({Key? key}) : super(key: key);

  @override
  State<confirm_booking> createState() => _confirm_bookingState();
}

class _confirm_bookingState extends State<confirm_booking> {

  Future<bool> acceptBooking(int i) async {
    log("Aceptando el boking...");
    log(widget.bookings[i].user.toString());
    var booking = widget.bookings[i];
    if (booking.id != null) {
      await BookingService.answerBookingPetition(booking.id!, 1);
    }
    getPendingBookingsFromBackend();
    setState(() {

    });
    return true;
  }

  Future<bool> declineBooking(int i) async {
    log("Rechazando el boking...");
    log(widget.bookings[i].user.toString());
    var booking = widget.bookings[i];
    if (booking.id != null) {
      await BookingService.answerBookingPetition(booking.id!, 0);
    }
    getPendingBookingsFromBackend();
    setState(() {

    });
    return true;
  }

  Future<void> getPendingBookingsFromBackend() async {
    widget.waitingBackend = true;
    widget.bookings = (await BookingService.getBookingsByType("pending")).cast<bkn.Booking>();
    log("##########################################");
    log(widget.bookings.toString());
    widget.waitingBackend = false;
    setState(() {

    });
  }
  
  String cutDownString(var s, int max){
    if(s==null) return "";
    if(s.toString().length <=max) return " "+s;
    return " "+s.substring(0,max)+"...";
  }

  @override
  void initState() {
    getPendingBookingsFromBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas pendientes'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, left: 5.0),
            child: Icon(Icons.pending_actions),
          ),
        ],backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
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
            "No hay reservas pendientes por confirmar",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45
            ),),
        ):
        ListView.builder(
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
                        children:  [
                          Text(
                            "INICIO",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Color(0xA0052e42)),
                          ),
                          Row(
                            children: [
                              Text(
                                (booking.publication.type== "Charger")?
                                  cutDownString(booking.publication.charger?.title ?? 'Sin título',ConfirmAndHistoryConfig.maxTitleCaracters) :
                                  cutDownString(booking.publication.bike?.title  ?? 'Sin títutlo',ConfirmAndHistoryConfig.maxTitleCaracters),
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
                                  Text(' ${DateFormat('hh:mm').format(booking.start_date)} h'),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_circle_right,color: Colors.blue,size: 35,),
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
                                  Text(' ${DateFormat('hh:mm').format(booking.end_date)} h',),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: const BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () {
                                  // Acción para rechazar la reserva
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Row(
                                        children: const [
                                          Icon(Icons.error, color: Colors.redAccent,),
                                          Text(' Rechazar reserva'),
                                        ],
                                      ),
                                      content: const Text('Se eliminará la reserva que ha realizado el usuario'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'cancelar'),
                                          child: const Text('cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: ()
                                          async {
                                            Navigator.pop(context, 'ok');
                                            if(await declineBooking(index)){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(Duration(milliseconds: 350), () {
                                                      Navigator.of(context).pop(true);
                                                    });
                                                    return AlertDialog(
                                                      title:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.close,color: Colors.redAccent,),
                                                          Text('Rechazando reserva...',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.redAccent
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          },
                                          child: const Text('ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.close,color: Colors.red,),
                                    Text(
                                      ' Rechazar  ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Icon(Icons.person, color: Color(0xf0052e42),size: 16,),
                                  Text(' ${cutDownString(booking.user.username,12)}',style: TextStyle(fontSize: 12),),
                                ],
                              ),


                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.green)
                                        )
                                    )

                                ),
                                onPressed: () async {
                                  if(await acceptBooking(index)){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(milliseconds: 350), () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return AlertDialog(
                                            title:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.check,color: Colors.green,),
                                                  Text('Aceptando reserva...',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green
                                                    ),
                                            ),
                                                ],
                                              ),
                                          );
                                        });
                                  }

                                  // Acción para rechazar la reserva
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '   Aceptar  ',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Icon(Icons.check,color: Colors.green,),
                                  ],
                                ),
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
    );
  }
}



