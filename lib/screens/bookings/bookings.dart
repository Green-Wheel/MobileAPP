import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../home/home.dart';

void main() {
  runApp(const MyBookings());
}

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bookings',
      theme: ThemeData(
        backgroundColor: Colors.white, //CupertinoColors.extraLightBackgroundGray,
      ),
      home: const MyBookingsPage(),
    );
  }
}

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  List bookings = [];
  List ratings = [];
  bool pressFilterByDate = false;
  bool pressFilterByChargers = false;
  bool pressFilterByBikes = false;
  bool pressFilterByLocation = false;

  @override
  void initState() {
    super.initState();
    _getBookings();
    _getRatings();
  }

  void _getRatings() async {
    BackendService.get('ratings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        //print(jsonResponse);
        setState(() {
          ratings = jsonResponse;
        });
      } else {
        print('Error getting bookings!');
      }
    });
  }

  void _getBookings() async {
    BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        //print(jsonResponse);
        setState(() {
          bookings = jsonResponse;
        });
      } else {
        print('Error getting bookings!');
      }
    });
  }

  void _cancelBooking(id) async {
    BackendService.delete('bookings/$id/').then((response) {
      if (response.statusCode == 204) {
        print('Booking cancelled!');
      } else {
        print('Error deleting booking!');
        print(response.statusCode);
      }
    });
  }

  Widget _buildCard(int id, String location, String rating, int distance, String time) =>
      Card(
        elevation: 10,
        color: CupertinoColors.white,
        shadowColor: Colors.green,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 175,
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 3.0, top: 15.0),
                child: Row(
                  children: [
                    Text(location,
                        style: const TextStyle(fontWeight: FontWeight.w600)
                    ),
                    Icon(
                      Icons.bolt,
                      size: 25,
                      color: Colors.green[500],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: double.parse(rating),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 3.5),
                child: Row(
                  children: [
                    Text('Charging point - ($distance km)',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),
                child: Row(
                  children: [
                    const Text('Available: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                    Text(time,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 20,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text('Matching with your car charger',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 5.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 30,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.lightBlue[50]!),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0),
                                          side: const BorderSide(
                                              color: Colors.blueAccent)
                                      )
                                  )
                              ),
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Text('Route ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueAccent),
                                  ),
                                  Icon(
                                    Icons.directions,
                                    size: 20,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 30,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.lightBlue[50]!),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0),
                                          side: const BorderSide(
                                              color: Colors.blueAccent)
                                      )
                                  )
                              ),
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Text('Chat ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueAccent),
                                  ),
                                  Icon(
                                    Icons.chat,
                                    size: 20,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                    Color>(Colors.red[50]!),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            18.0),
                                        side: const BorderSide(
                                            color: Colors.red)
                                    )
                                )
                            ),
                            onPressed: () {
                              print(id);
                              _cancelBooking(id);
                              _getBookings();
                              _getRatings();
                              buildList();
                            },
                            child: Row(
                              children: const [
                                Text('Cancel ',
                                  style: TextStyle(fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                                Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildList() => ListView.builder(
    itemCount: bookings.length,
    itemBuilder: (context, index) {
      // Guarda a rate el rating de la reserva <-- De moment això és temporal fins que s'implementi poder valorar un carregador (ara es passa una mitjana hardcoded)
      String rate = "";
      for (int i = 0; i < ratings.length; i++) {
        if (bookings[index]['id'].toString() == ratings[i]['booking'].toString()) {
          rate = ratings[i]['rate'].toString();
        }
      }
      if (rate == "") {
        rate = "0";
      }

      // Nom de la publicació del carregador reservat
      List<dynamic> publicationName = bookings[index]['publication'];

      var endDate = DateTime.parse(bookings[index]['end_date']);
      var startDate = DateTime.parse(bookings[index]['start_date']);
      DateFormat formatterStart = DateFormat('HH:mm');
      DateFormat formatterEnd = DateFormat('HH:mm');
      String formattedTimeStart = formatterStart.format(startDate);
      String formattedTimeEnd = formatterEnd.format(endDate);
      if (bookings[index]['cancelled'] == false) {
        return _buildCard(
            bookings[index]['id'], publicationName[0]['description'], rate, index+1,
            '$formattedTimeStart-$formattedTimeEnd');
      } else {
        return Container();
      }
    },
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis Reservas'),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 105.0),
              child: Icon(Icons.calendar_month),
            ),
          ],
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 7.5, bottom: 1),
                    child: SizedBox(
                      height: 35,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: pressFilterByDate ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        7.5),
                                    side: BorderSide(
                                        color: pressFilterByDate ? Colors.green : Colors.grey[700]!)
                                )
                            )
                        ),
                        onPressed: () {
                          setState(() => pressFilterByDate = !pressFilterByDate);
                          if (pressFilterByDate) {
                            bookings.sort((a, b) => a['start_date'].compareTo(b['start_date']));
                          } else {
                            bookings.sort((a, b) => a['id'].compareTo(b['id']));
                          }
                          buildList();
                        },
                        child: Row(
                          children: [
                            Text('Date ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: pressFilterByDate ? Colors.green : Colors.grey[700]!),
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: pressFilterByDate ? Colors.green : Colors.grey[700]!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                    child: SizedBox(
                      height: 35,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: pressFilterByChargers ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        7.5),
                                    side: BorderSide(
                                        color: pressFilterByChargers ? Colors.green : Colors.grey[700]!)
                                )
                            )
                        ),
                        onPressed: () => setState(() => pressFilterByChargers = !pressFilterByChargers),
                        child: Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              size: 20,
                              color: pressFilterByChargers ? Colors.green : Colors.grey[700]!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                    child: SizedBox(
                      height: 35,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: pressFilterByBikes ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        7.5),
                                    side: BorderSide(
                                        color: pressFilterByBikes ? Colors.green : Colors.grey[700]!)
                                )
                            )
                        ),
                        onPressed: () => setState(() => pressFilterByBikes = !pressFilterByBikes),
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions_bike,
                              size: 20,
                              color: pressFilterByBikes ? Colors.green : Colors.grey[700]!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                    child: SizedBox(
                      height: 35,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: pressFilterByLocation ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        7.5),
                                    side: BorderSide(
                                        color: pressFilterByLocation ? Colors.green : Colors.grey[700]!)
                                )
                            )
                        ),
                        onPressed: () => setState(() => pressFilterByLocation = !pressFilterByLocation),
                        child: Row(
                          children: [
                            Text('Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: pressFilterByLocation ? Colors.green : Colors.grey[700]!),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 20,
                                color: pressFilterByLocation ? Colors.green : Colors.grey[700]!
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        )
    );
  }
}

