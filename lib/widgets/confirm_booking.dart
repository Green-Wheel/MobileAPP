import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:greenwheel/widgets/booking_calendar2.dart';
import 'package:intl/intl.dart';
import 'package:greenwheel/services/backendServices/bookings.dart';
import '../../serializers/bookings.dart' as bkn;

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

  Future<void> getPendingBookingsFromBackend() async {
    //widget.waitingBakend = true;
    widget.bookings = (await BookingService.getPendingToConfirmBookings()).cast<bkn.Booking>();
    log(widget.bookings.toString());
    setState(() {

    });
  }

  @override
  void initState() {
    getPendingBookingsFromBackend();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: (widget.bookings.length <= 0 )?
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child:
          const Text(
            "No hay reservas pendientes de confirmar",
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
                        children: [
                          Text(
                            "INICIO",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Color(0xA0052e42)),
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
                                  Icon(Icons.calendar_month, color: Color(0xF0052e42),),
                                  Text(' ${DateFormat('yyyy·MM·dd').format(booking.start_date)}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Color(0xF0052e42)),
                                  Text(' ${DateFormat('hh:mm').format(booking.start_date)} h'),
                                ],
                              ),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_circle_right,color: Colors.blue,size: 35,),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Icon(Icons.calendar_month,color: Color(0xF0052e42)),
                                  Text(' ${DateFormat('yyyy·MM·dd').format(booking.start_date)}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time,color: Color(0xF0052e42),                                                                ),
                                  Text(' ${DateFormat('hh:mm').format(booking.start_date)} h',),
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
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
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
                                            side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () {
                                  // Acción para rechazar la reserva
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Row(
                                        children: [
                                          const Icon(Icons.error, color: Colors.redAccent,),
                                          const Text(' Rechazar reserva'),
                                        ],
                                      ),
                                      content: const Text('Se eliminará la reserva que ha realizado el usuario'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'cancelar'),
                                          child: const Text('cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'ok'),
                                          child: const Text('ok'),
                                        ),

                                      ],
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
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
                                  Icon(Icons.person, color: Color(0xf0052e42),),
                                  Text(' ${booking.user.username}'),
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
                                onPressed: () {

                                  // Acción para rechazar la reserva
                                },
                                child: Row(
                                  children: [
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




