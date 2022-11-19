import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/widgets/button_route.dart';
import 'package:greenwheel/widgets/image_charger.dart';
import 'package:greenwheel/widgets/location_charger.dart';
import 'package:greenwheel/widgets/match_with_car.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

class CardInfoWidget extends StatefulWidget {
  String location;
  double rating;
  int types;
  bool available;
  bool match;

  CardInfoWidget({required this.location, required this.rating, required this.types, required this.available, required this.match, super.key});

  @override
  State<StatefulWidget> createState() => _CardInfoWidget();
}

class _CardInfoWidget extends State<CardInfoWidget>{
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
          color: Color(0xff43802a),
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        height: 175,
        width: 400,
        child: Row(
          children: [
            SizedBox(
              width: 270,
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5, left: 25),
                    child: LocationChargerWidget(location: location),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child:  StarsStaticRateWidget(rate: 4.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child:  PointOfChargeDistWidget(types: types),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: AvaliablePublicChargerWidget(avaliable: avaliable),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: MatchWithCarWidget(match: match),
                  ),
                ],
              ),
            ),
            Column(
              children: const [
                ImageChargerWidget(),
                ButtonRouteWidget(latitude: 41.3874, longitude: 2.1686),
              ],
            ),
          ],
        ),
      ),
    );
}

