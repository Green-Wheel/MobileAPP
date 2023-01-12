import 'dart:convert';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/bookings.dart';
import 'package:greenwheel/widgets/action_buttons_reservation.dart';

//import '../../serializers/ratings.dart';
import '../../services/backendServices/bookings.dart';
import '../../widgets/reservation_bike_card.dart';
import '../../widgets/reservation_charger_card.dart';

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
  List<Booking> bookings = [];
  List ratings = [];
  bool pressFilterByDate = false;
  bool pressFilterByChargers = false;
  bool pressFilterByBikes = false;
  bool pressFilterByLocation = false;

  @override
  void initState() {
    super.initState();
    //_getRatings();
    _getBookings();
  }

  /*void _getRatings() async {
    List? ratingList = await RatingService.getRatings();
    setState(() {
      if (ratingList != null) {
        ratings = ratingList;
      }
    });
  }*/

  void _getRatingsRand(int length) {
    for (int i = 0; i < length; i++) {
      Random random = Random();
      int min = 2, max = 6;
      int num = (min + random.nextInt(max - min));
      double numd = num.toDouble();
      ratings.add(numd);
    }
  }

  void _showAvisNoEsPodenCarregarBookings() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bookings Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load bookings'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getBookings() async {
    List<Booking> bookingList = await BookingService.getBookings();
    if (bookingList.isEmpty) {
      _showAvisNoEsPodenCarregarBookings();
    }
    print("bookings: $bookingList");
    setState(() {
      bookings = bookingList;
      _getRatingsRand(bookings.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis Reservas'),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width / 3.5),
              child: const Icon(Icons.calendar_month),
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

Widget buildList(List<Booking> bookings, ratings) => ListView.builder(
  itemCount: bookings.length,
  itemBuilder: (context, index) {
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    String rate = num.toDouble().toString();

    if (bookings[index].status.name == "Confirmed") {
      if (bookings[index].publication.type == "Charger") {
        return ReservationChargerCard(booking: bookings[index], rating: rate);
      } else {
        return ReservationBikeCard(booking: bookings[index], rating: rate);
      }
    } else {
        return Container();
    }
  },
);

