import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';
import 'package:provider/provider.dart';

import 'buttons_card.dart';

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
bool _isVisible = true;

class _ReservationCard extends State<ReservationCard> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _buildCard(widget.bookings, widget.ratings, widget.id, widget.location, widget.rating, widget.distance,
        widget.time, width, height);
  }

  Widget _buildCard(List bookings, List ratings, int id, String location,
      String rating, int distance, String time, double width, double height) =>
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
            width: width * 0.9,
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
                  child: ButtonsCard(longitude: 41.389622159782746, latitude: 2.113375926632859, function: callSetState, id: id),
                ),
              ],
            ),
          ),
        ),
      );

  callSetState() {
    setState(() {
      _isVisible = false;
    });
  }
}