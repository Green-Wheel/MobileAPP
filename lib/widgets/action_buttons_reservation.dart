import 'package:flutter/material.dart';
import '../screens/bookings/bookings.dart';

class ActionButtonsReservation extends StatefulWidget {
  List bookings;
  List ratings;

  ActionButtonsReservation({required this.bookings, required this.ratings, super.key});

  @override
  State<StatefulWidget> createState() => _ActionButtonsReservationWidget();
}

class _ActionButtonsReservationWidget extends State<ActionButtonsReservation> {
  bool pressFilterByDate = false;
  bool pressFilterByChargers = false;
  bool pressFilterByBikes = false;
  bool pressFilterByLocation = false;

  @override
  Widget build(BuildContext context) {
    return _actionButtonsReservation(widget.bookings, widget.ratings);
  }

  Widget _actionButtonsReservation(List bookings, List ratings) {
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
                        bookings.sort((a, b) => a['start_date'].compareTo(b['start_date']));
                      } else {
                        bookings.sort((a, b) => a['id'].compareTo(b['id']));
                      }
                      buildList(bookings, ratings);
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
          child: buildList(bookings, ratings),
        ),
      ],
    );
  }
}



