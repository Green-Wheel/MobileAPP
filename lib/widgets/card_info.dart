import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/widgets/button_reserva_list.dart';
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
  bool avaliable;
  bool match;
  bool private;
  bool full_info;


  CardInfoWidget({required this.location, required this.rating, required this.types, required this.avaliable, required this.match, required this.private, required this.full_info, super.key});

  @override
  State<StatefulWidget> createState() => _CardInfoWidget();
}

class _CardInfoWidget extends State<CardInfoWidget>{
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.location, widget.rating, widget.types, widget.avaliable, widget.match, widget.private, widget.full_info, context);
  }
}

Widget _buildCard(String location, double rating, int types, bool avaliable,  bool match, bool private, bool full_info, BuildContext context){
  return Card(
    elevation: 10,
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff43802a),
        width: 3,
      ),
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.2, //0.25
      width: MediaQuery.of(context).size.width * 0.8,
      child:Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.725,
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: LocationChargerWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child:   StarsStaticRateWidget(rate: rating),
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
                /*private? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                    child:Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: ButtonReservaListWidget(),
                    ),
                ): SizedBox(height: 0),*/
               private? full_info ? ButtonReservaListWidget() : SizedBox(height: 0) : SizedBox(height: 0),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.195,
            child: Column(
              children: [
                SizedBox(height: 20),
                ImageChargerWidget(),
                SizedBox(height: 10),
                ButtonRouteWidget(latitude: 41.3874, longitude: 2.1686),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


