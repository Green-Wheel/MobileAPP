import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

import '../serializers/bookings.dart';
import 'buttons_card.dart';

class ReservationBikeCard extends StatefulWidget {
  Booking booking;
  String rating;

  ReservationBikeCard({required this.booking, required this.rating, super.key});

  @override
  State<StatefulWidget> createState() => _ReservationBikeCard();

}
bool _isVisible = true;

class _ReservationBikeCard extends State<ReservationBikeCard> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _buildCard(widget.booking, widget.rating, width, height);
  }

  callSetState() {
    setState(() {
      _isVisible = false;
    });
  }

  Widget _buildCard(Booking booking, String rating, double width, double height) {
    String bikeName = "bike";
    if (booking.publication.bike?.title != null) {
      bikeName = booking.publication.bike!.title!;
    }

    int distance = 2;

    DateFormat formatterStart = DateFormat('dd-MM (kk:mm)');
    DateFormat formatterEnd = DateFormat('dd-MM (kk:mm)');
    String formattedTimeStart = formatterStart.format(booking.start_date);
    String formattedTimeEnd = formatterEnd.format(booking.end_date);

    int id = 1;
    if (booking.id != null) {
      id = booking.id!;
    }

    String statusName = booking.status.name;

    return Visibility(
      visible: _isVisible,
      child: Card(
        elevation: 10,
        color: Colors.white,
        shadowColor: Colors.green,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Expanded(child:
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, bottom: 3.0, top: 15.0),
            child: Row(
              children: [
                Flexible(child:
                Text(bikeName,
                    style: const TextStyle(fontWeight: FontWeight.w600))
                ),
                Icon(
                  Icons.pedal_bike,
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
                Text('Bike - ($distance km)',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),
            child: Row(
              children: [
                Text('$statusName: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.green),
                ),
                Text('$formattedTimeStart - $formattedTimeEnd',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10.0, bottom: 10.0),
            child: ButtonsCard(longitude: 41.389622159782746,
                latitude: 2.113375926632859,
                function: callSetState,
                id: id, charger: false,),
          ),
        ],
        ),
        ),
      ),
    );
  }
}