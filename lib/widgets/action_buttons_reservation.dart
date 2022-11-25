import 'package:flutter/material.dart';
import '../screens/bookings/bookings.dart';
import '../serializers/bookings.dart';
import '../services/backendServices/bookings.dart';

class ActionButtonsReservation extends StatefulWidget {
  List<Booking> bookings;
  List<dynamic>? ratings;

  ActionButtonsReservation({required this.bookings, required this.ratings, super.key});

  @override
  State<StatefulWidget> createState() => _ActionButtonsReservationWidget();
}

class _ActionButtonsReservationWidget extends State<ActionButtonsReservation> {
  bool pressFilterByDate = false;
  bool pressFilterByChargers = false;
  bool pressFilterByBikes = false;
  bool pressFilterByLocation = false;
  List<Booking> bookingOfChargers = [];
  List<Booking> bookingOfBikes = [];

  @override
  Widget build(BuildContext context) {
    return _actionButtonsReservation(widget.bookings, widget.ratings);
  }

  void _getBookingsOrderedBy(String orderBy) async {
    List<Booking> bookingList = await BookingService.getBookingsOrderedBy(orderBy);
    setState(() {
      widget.bookings = bookingList;
    });
  }

  void _getBookings() async {
    List<Booking> bookingList = await BookingService.getBookings();
    setState(() {
      widget.bookings = bookingList;
    });
  }

  void _getBookingsOfChargers() {
    for (int i = 0; i < widget.bookings.length; i++) {
      if (widget.bookings[i].publication.type == "Charger") {
        bookingOfChargers.add(widget.bookings[i]);
      }
    }
    setState(() {
      widget.bookings = bookingOfChargers;
    });
  }

  void _getBookingsOfBikes() {
    for (int i = 0; i < widget.bookings.length; i++) {
      if (widget.bookings[i].publication.type == "Bike") {
        bookingOfBikes.add(widget.bookings[i]);
      }
    }
    setState(() {
      widget.bookings = bookingOfBikes;
    });
  }

  Widget _actionButtonsReservation(List<dynamic>? bookings, List<dynamic>? ratings) {
    return Column(
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
                        _getBookingsOrderedBy("date");
                      } else {
                        _getBookings();
                      }
                      buildList(widget.bookings, ratings);
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
                                borderRadius: BorderRadius.circular(7.5),
                                side: BorderSide(
                                    color: pressFilterByChargers ? Colors.green : Colors.grey[700]!)
                            )
                        )
                    ),
                    onPressed: () {
                      setState(() => pressFilterByChargers = !pressFilterByChargers);
                      if (pressFilterByChargers) {
                        _getBookingsOfChargers();
                      } else {
                        _getBookings();
                      }
                    },
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
                    onPressed: () {
                      setState(() => pressFilterByBikes = !pressFilterByBikes);
                      if (pressFilterByBikes) {
                        _getBookingsOfBikes();
                      } else {
                        _getBookings();
                      }
                    },
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
              /*Padding(
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
              ),*/
            ],
          ),
        ),
        Expanded(
          child: buildList(widget.bookings, ratings),
        ),
      ],
    );
  }
}



