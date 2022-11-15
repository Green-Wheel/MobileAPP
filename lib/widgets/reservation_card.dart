import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/backendServices/bookings.dart';
// import 'package:go_router/go_router.dart';


class ReservationCard extends StatefulWidget {
  List bookings;
  List ratings;
  int id;
  String location;
  String rating;
  int distance;
  String time;
  ReservationCard({required this.bookings, required this.ratings,
    required this.id, required this.location, required this.rating,
    required this.distance, required this.time, super.key});

  @override
  State<StatefulWidget> createState() => _ReservationCard();
}

class _ReservationCard extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.bookings, widget.ratings, widget.id, widget.location, widget.rating, widget.distance,
        widget.time);
  }

  bool _isVisible = true;

  Widget _buildCard(List bookings, List ratings, int id, String location, String rating, int distance, String time) =>
     Visibility(
       visible: _isVisible,
       child: Card(
          elevation: 10,
          color: Colors.white,
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
                  child: RatingStars(rating: rating),
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
                                onPressed: () {
                                  // GoRouter.of(context).go('/route/${widget.longitude}/${widget.latitude}');
                                },
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
                                BookingService.deleteBookings(id);
                                // print('$id cancelled');
                                setState(() {
                                  _isVisible = false;
                                });
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
        ),
  );
}


