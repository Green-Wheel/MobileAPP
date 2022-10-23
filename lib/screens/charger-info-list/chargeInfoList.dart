import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/charger-info/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_route.dart';
import 'package:greenwheel/screens/charger-info/widgets/image_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/location_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/match_with_car.dart';
import 'package:greenwheel/screens/charger-info/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/screens/charger-info/widgets/stars_static_rate.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/screens/charger-info/chargeInfo.dart';
import 'package:permission_handler/permission_handler.dart';


void main(){runApp(const MaterialApp(
  title: 'chargeInfoList try',
  home: Scaffold(
    body: ChargeInfoList(),
  ),
));}


class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}
abstract class Marcador {
  late int id;
  late double latitude;
  late double longitude;
  late String direction;
  late double power;
  late String town;
}

List<Marcador> markers = [];
List markersList = [];
List<String> element = [
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
];

void _getPublicChargers() async {
  BackendService.get('chargers/public/').then((response)  {
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      markersList = jsonResponse;
      Marcador? mark;
      for (int i = 0; i < markersList.length; i++) {
        Map localization = markersList[i]['localization'];
        double latitude = localization['latitude'];
        double longitude = localization['longitude'];
        String direction = "No description";
        if (markersList[i]['direction'] != null) {
          direction = markersList[i]['direction'];
        }
        double power =  markersList[i]['power'];
        String town = markersList[i]['town'];
        mark!.id = i;
        mark.latitude = latitude;
        mark.longitude = longitude;
        mark.direction = direction;
        mark.power = power;
        mark.town = town;
        markers.add(mark);
      }
    }
  });
}

@override
void initState(){
  _getPublicChargers();
}

class _ChargeInfoListState extends State<ChargeInfoList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargers Markers'),
        centerTitle: true,
        actions: const [
        Padding(
          padding: EdgeInsets.only(right: 105.0, left: 5.0),
          child: Icon(Icons.location_on_outlined),
          ),
        ],backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Tornar a HomePage
              /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );*/
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 25,
        /*addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,*/
        itemBuilder: (context, position) {
         //Marcador item = markers[position];
          return Stack(
            key: Key(element[position]),
            children: [
              _cardChargerList(markersList.length.toString(), true, true),
            ],
          );
        }
      ),
    );
  }
}


//funcion respectiva a la card de los cargadores
Widget _cardChargerList(String direction, bool avaliable, bool match){
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
      child:Row(
        children: [
          SizedBox(
            width: 270,
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 25),
                  child: LocationChargerWidget(location: direction),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:  StarsStaticRateWidget(rate: 4.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:  PointOfChargeDistWidget(distance: 2),
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
            children:const [
              Padding(
                padding:EdgeInsets.only(right: 25),
                child: ImageChargerWidget(),
              ),
              Padding(
                padding:EdgeInsets.only(right: 0),
                child: ButtonRouteWidget(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
