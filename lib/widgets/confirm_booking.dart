import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    List<Booking> bookings=[];
    var booking =  Booking(startDate: date, endDate: date.add(Duration(hours: 1)),userName: "dani.ou",confirmed: true);
    bookings.add(booking);
    bookings.add(booking);
    bookings.add(booking);
    bookings.add(booking);
    bookings.add(booking);


    return MaterialApp(
      title: 'Confirm booking',
      home: confirm_booking(bookings: bookings,),
    );
  }
}

class confirm_booking extends StatelessWidget {
  final List<Booking> bookings;
  

  const confirm_booking({Key? key, required this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (BuildContext context, int index) {
          Booking booking = bookings[index];
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
                                Text(' ${DateFormat('yyyy·MM·dd').format(booking.startDate)}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, color: Color(0xF0052e42)),
                                Text(' ${DateFormat('hh:mm').format(booking.startDate)} h'),
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
                                Text(' ${DateFormat('yyyy·MM·dd').format(booking.startDate)}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: Color(0xF0052e42),                                                                ),
                                Text(' ${DateFormat('hh:mm').format(booking.startDate)} h',),
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
                                        onPressed: () => Navigator.pop(context, 'ok'),
                                        child: const Text('ok'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'cancelar'),
                                        child: const Text('cancelar'),
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
                                Text(' ${booking.userName}'),
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
    );
  }
}

class Booking {
  final DateTime startDate;
  final DateTime endDate;
  final String userName;
  final bool confirmed;

  Booking({required this.startDate, required this.endDate, required this.userName, required this.confirmed});
}
