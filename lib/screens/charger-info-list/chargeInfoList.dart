import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:greenwheel/screens/charger-info/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_route.dart';
import 'package:greenwheel/screens/charger-info/widgets/image_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/location_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/match_with_car.dart';
import 'package:greenwheel/screens/charger-info/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/screens/charger-info/widgets/stars_static_rate.dart';


void main(){runApp(const MaterialApp(
  title: 'chargeInfoList try',
  home: Scaffold(
    body: ChargeInfoList(),
  ),
));}

//TODO: Acabar de confeccionar el modelo en el que llegaran los datos (preguntar)
class Locations{
  late String direction;
  late String town;
  late double latitude;
  late double longitude;

}

class Info {
  late bool avaliable;
  late String speed;
  late Float power;
  late String charger_type;
  late String type_veichle;
  late bool match;
}

class Marcador {
  late String identifier;
  late bool is_public;
  late List<Locations> geolocation;
  late List<Info> info;
}



class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}
List<Marcador> elements = {} as List<Marcador>;
List<String> element = [
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
];

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
          return Stack(
            key: Key(element[position]),
            children:[
              _cardChargerList("location", true, true),
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 135),
                child: LocationChargerWidget(location: direction),
              ),
              Padding(
                padding: EdgeInsets.only(right: 65),
                child:  StarsStaticRateWidget(rate: 4.0),
              ),
              Padding(
                padding: EdgeInsets.only(right: 55),
                child:  PointOfChargeDistWidget(distance: 2),
              ),
              Padding(
                padding: EdgeInsets.only(right: 83),
                child: AvaliablePublicChargerWidget(avaliable: avaliable),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: MatchWithCarWidget(match: match),
              ),
            ],
          ),
          Column(
            children:const [
              Padding(
                padding:EdgeInsets.only(left: 8),
                child: ImageChargerWidget(),
              ),
              Padding(
                padding:EdgeInsets.only(left: 5),
                child: ButtonRouteWidget(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
