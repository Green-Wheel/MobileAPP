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
  double? rating;
  bool available;
  BikeType type;
  double price;
  String? description;
  String? direction;
  double power;
  bool bike_list;
  int? id;

  BikeCardInfoWidget({required this.location, required this.rating, required this.available,  required this.type,  required this.price,  required this.description,  required this.direction,  required this.power,  required this.bike_list, required this.id, super.key});

  @override
  State<StatefulWidget> createState() => _BikeCardInfoWidget();
}

class _BikeCardInfoWidget extends State<BikeCardInfoWidget>{
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.location, widget.rating, widget.available, widget.type, widget.price, widget.description, widget.direction, widget.power, widget.bike_list, widget.id, context);
  }
}

Widget _buildCard(String? location, double? rating, bool available, BikeType type, double price, String? description, String? direction, double power, bool bike_list, int? id, BuildContext context) {
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
                child: LocationBikeWidget(location: location!, bikeType: type.id),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:  StarsStaticRateWidget(rate: rating!),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.725,
                child: type.name == "Electric" ? Padding(
                padding: EdgeInsets.only(left: 25),
                child: !bike_list ? Text('Electric: $power W',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green)
                ) : Text('Electric', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green))) :
                Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: const Text('Manual',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent)),
                )
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: AvaliableBikeWidget(avaliable: available),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25),
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
              ),
              !bike_list ? SizedBox(height: 65): SizedBox(height: 0),
              !bike_list ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.925,
                child: Flexible(
                  child: Column(
                    children:[
                      !bike_list? ButtonReservaListBikeWidget(id: id): SizedBox(height: 0),
                      !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                      !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                      !bike_list? Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.925,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text("Address:  $direction",style: const TextStyle(fontWeight: FontWeight.w600))
                                    ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.925,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text("Description:  $description",
                                      style: const TextStyle(fontWeight: FontWeight.w600)
                                  ),
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
              SizedBox(height: 20),
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

