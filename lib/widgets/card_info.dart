import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/widgets/button_reserva_list.dart';
import 'package:greenwheel/widgets/button_route.dart';
import 'package:greenwheel/widgets/chat_button.dart';
import 'package:greenwheel/widgets/image_charger.dart';
import 'package:greenwheel/widgets/location_charger.dart';
import 'package:greenwheel/widgets/match_with_car.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

import '../serializers/chargers.dart';

class CardInfoWidget extends StatefulWidget {
  String? location;
  double rating;
  List<ConnectionType> types;
  bool available;
  bool match;
  bool private;
  double price;
  String? description;
  String? direction;
  bool private_list;

  CardInfoWidget({required this.location, required this.rating, required this.types, required this.available, required this.match, required this.private, required this.price, required this.description, required
  this.direction, required this.private_list, super.key});

  @override
  State<StatefulWidget> createState() => _CardInfoWidget();
}

class _CardInfoWidget extends State<CardInfoWidget>{
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.location, widget.rating, widget.types, widget.available, widget.match, widget.private, widget.price, widget.description, widget.direction, widget.private_list, context);
  }
}

Widget _buildCard(String? location, double rating, List<ConnectionType> types, bool avaliable, bool match, bool private, double price, String? description, String? direction, bool private_list, BuildContext context){
  return Card(
    elevation: 10,
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.725,
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 25),
                  child: LocationChargerWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: StarsStaticRateWidget(rate: rating),//StarsStaticRateWidget(rate: 4.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: PointOfChargeDistWidget(types: types),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 193),
                  child: private ? const Text('Private',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent)
                  ) : const Text('Public',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 193),
                  child: private_list ? const Text('Private',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent)
                  ) : SizedBox()),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: AvaliablePublicChargerWidget(avaliable: avaliable),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: MatchWithCarWidget(match: match),
                ),
                private? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.925,
                  child: Flexible(
                    child:Column(
                    children: [
                      private? SizedBox(height: 10): SizedBox(height: 0),
                      private? SizedBox(height: 60) : SizedBox(height: 0),
                      private? ButtonReservaListWidget() : SizedBox(height: 0),
                      private? SizedBox(height: 20):  SizedBox(height: 0),

                      //private? SizedBox(height: 10): SizedBox(height: 0),
                      private? Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:Row(
                            children: [
                                Text("Price: ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(price.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              const Text(" €/KWh",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                      ): SizedBox(height: 0),
                      private? SizedBox(height: 10): SizedBox(height: 0),
                      private? Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 35),
                              child:Text("Address:  $direction",
                                  style: const TextStyle(fontWeight: FontWeight.w600)
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 115),
                              child:Text("Description:  $description",
                                  style: const TextStyle(fontWeight: FontWeight.w600)
                              ),
                          ),
                        ]): SizedBox(height: 0),
                      SizedBox(height: 10),
                    ],
                  ),
                )
                ): SizedBox(height: 0),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.215,
            child: Column(
              children:  [
                  SizedBox(height: 30),
                  ImageChargerWidget(),
                  SizedBox(height: 10),
                  ButtonRouteWidget(latitude: 41.3874, longitude: 2.1686),
                  private? SizedBox(height: 155): SizedBox(height: 35),
                  private?  Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: ChatButtonWidget(longitude: 42.012, latitude: 41.675)
                  ,): SizedBox(height: 25)
              ],
            ),
          ),
        ],
    ),
  );
}
