import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/button_blue_route.dart';
import 'package:greenwheel/widgets/button_reserva_list.dart';
import 'package:greenwheel/widgets/image_bike.dart';
import 'package:greenwheel/widgets/location_bike.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

import '../serializers/bikes.dart';
import 'available_bike.dart';
import 'button_reserva_list_bike.dart';

class BikeCardInfoWidget extends StatefulWidget {
  String? location;
  double rating;
  bool available;
  BikeType type;
  double price;
  String? description;
  String? direction;
  double power;
  bool bike_list;

  BikeCardInfoWidget({required this.location, required this.rating, required this.available,  required this.type,  required this.price,  required this.description,  required this.direction,  required this.power,  required this.bike_list, super.key});

  @override
  State<StatefulWidget> createState() => _BikeCardInfoWidget();
}

class _BikeCardInfoWidget extends State<BikeCardInfoWidget>{
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.location, widget.rating, widget.available, widget.type, widget.price, widget.description, widget.direction, widget.power, widget.bike_list, context);
  }
}

Widget _buildCard(String? location, double rating, bool available, BikeType type, double price, String? description, String? direction, double power, bool bike_list, BuildContext context) {
  return Card(
    elevation: 10,
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.725,
          child:Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5, left: 25),
                child: LocationBikeWidget(location: location!),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:  StarsStaticRateWidget(rate: 4.0),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 193),
                child: type.name == "electric" ? Text('Electric: $power W',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green)
                ) : const Text('Manual',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent))),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: AvaliableBikeWidget(avaliable: available),
              ),
              bike_list? Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
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
                          color: Colors.blue,
                        ),
                      ),
                      const Text(" €/h",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
              ): SizedBox(height: 0),
              !bike_list ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.925,
                child: Flexible(
                  child: Column(
                    children:[
                      !bike_list? ButtonReservaListBikeWidget(): SizedBox(height: 0),
                      !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                      !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                      !bike_list? Column(
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
                      SizedBox(height: 10)
                    ]
                  )
                )
              ) : SizedBox(height: 0),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.215,
          child: Column(
            children: [
              SizedBox(height: 30),
              ImageBikeWidget(),
              SizedBox(height: 10),
              ButtonBlueRouteWidget(latitude: 41.3874, longitude: 2.1686),
            ],
          ),
        )
      ],
    ),
  );
}

