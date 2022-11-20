import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:greenwheel/widgets/action_buttons_reservation.dart';

import '../../serializers/ratings.dart';
import '../../services/backendServices/bookings.dart';
import '../../services/backendServices/ratings.dart';
import '../../widgets/reservation_card.dart';
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
    _getRatings();
    _getBookings();
  }

  void _getRatings() async {
    List? ratingList = await RatingService.getRatings();
    setState(() {
      if (ratingList != null) {
        ratings = ratingList;
      }
    });
  }

  void _getBookings() async {
    List? bookingList = await BookingService.getBookings();
    setState(() {
      if (bookingList != null) {
        bookings = bookingList;
      }
    });
  }

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
        body: ActionButtonsReservation(bookings: bookings, ratings: ratings));
  }
}

Widget buildList(bookings, ratings) => ListView.builder(
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
      return ReservationCard(bookings: bookings, ratings: ratings, id: bookings[index]['id'],
          location: publicationName[0]['description'], rating: rate, distance: index+1,
          time: '$formattedTimeStart-$formattedTimeEnd');
    } else {
      return Container();
    }
  },
);

