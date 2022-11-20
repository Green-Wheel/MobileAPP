import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/button_blue_route.dart';
import 'package:greenwheel/widgets/image_bike.dart';
import 'package:greenwheel/widgets/location_bike.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

import 'available_bike.dart';

class BikeCardInfoWidget extends StatefulWidget {
  String location;
  double rating;
  int types;
  bool available;
  bool match;

  BikeCardInfoWidget({required this.location, required this.rating, required this.types, required this.available, required this.match, super.key});

  @override
  State<StatefulWidget> createState() => _BikeCardInfoWidget();
}

class _BikeCardInfoWidget extends State<BikeCardInfoWidget>{
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.location, widget.rating, widget.types, widget.available, widget.match, context);
  }
}

Widget _buildCard(String location, double rating, int types, bool avaliable,  bool match, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Card(
    elevation: 10,
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.blueAccent,
        width: 3,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Expanded(
      //height: MediaQuery.of(context).size.height * 0.27,
      //width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: [
          SizedBox(
            width: 270,
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 25),
                  child: LocationBikeWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:  StarsStaticRateWidget(rate: 4.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: AvaliableBikeWidget(avaliable: avaliable),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: ButtonBlueRouteWidget(latitude: 41.3874, longitude: 2.1686),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.215,
            child: Column(
              children: const [
                ImageBikeWidget(),
              ],
            ),
          )
        ],
      ),
    ),

  );
}

