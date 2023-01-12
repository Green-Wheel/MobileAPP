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

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();


    return MaterialApp(
      title: 'Confirm booking',
      home: past_confirm_booking(),
    );
  }
}

class past_confirm_booking extends StatefulWidget {
  List<bkn.Booking> bookings=[];
  bool waitingBackend = true;

  past_confirm_booking({Key? key}) : super(key: key);

  @override
  State<past_confirm_booking> createState() => _past_confirm_bookingState();
}

class _past_confirm_bookingState extends State<past_confirm_booking> {


  Future<void> getPendingBookingsFromBackend() async {
    widget.waitingBackend = true;
    widget.bookings = (await BookingService.getBookingsByType("historial")).cast<bkn.Booking>();
    log("##########################################");
    log(widget.bookings.toString());
    widget.waitingBackend = false;
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
      appBar: AppBar(
        title: const Text('Historial de reservas'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 5.0),
            child: Icon(Icons.history),
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
                                        Text(' ${DateFormat('hh:mm').format(booking.start_date)} h'),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        (booking.status.name == "Confirmed")?
                                        const Icon(Icons.check, color: Color(0xf0052e42),):
                                        const Icon(Icons.close, color: Color(0xf0052e42),),
                                        (booking.status.name == "Confirmed")?
                                        const Text(' Confirmada'):
                                        const Text(' Cancelada'),
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



