import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/charger-info/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_route.dart';
import 'package:greenwheel/screens/charger-info/widgets/image_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/location_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/match_with_car.dart';
import 'package:greenwheel/screens/charger-info/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/screens/charger-info/widgets/stars_static_rate.dart';
import 'package:greenwheel/services/backend_service.dart';

class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}

class _ChargeInfoListState extends State<ChargeInfoList>{

  List markersList = [];

  @override
  void initState(){
    super.initState();
    _getChargers();
  }

  /*void _getPublicChargers() async {
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
          mark!.latitude = latitude;
          mark!.longitude = longitude;
          mark!.direction = direction;
          mark!.power = power;
          mark!.town = town;
          markers.add(mark);
        }
      }
    });
  }*/

  void _getChargers() async {
    BackendService.get('chargers/public/').then((response)  {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        setState(() {
          markersList = jsonResponse;
        });
      } else {
        print('Error getting chargers!');
      }
    });
  }

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
              GoRouter.of(context).go('/');
            // Tornar a HomePage
              /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );*/
          },
        ),
      ),
      body: ListView.builder(
        itemCount: markersList.length,
        /*addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,*/
        itemBuilder: (context, position) {

          //Arreglo del titulo del cargador respecto a los datos del json
          String description = markersList[position]['description'];
          description = title_parser(description);

          //Mirar el tipo de la variable porque to_do  da null
          bool avaliable = true;
          //avaliable da null
          if (markersList[position]['description'] == "false") avaliable = false;

          //print(markersList[position]['connection_type']); //retorna numero de typos diferentes con el .lenght
          //print(markersList[position]['current_type']); //puede ser 1 o 2 -> AC - DC

          //Obtencion del numero de tipos de cargadores
          int types = markersList[position]['connection_type'].length;

          return _cardChargerList(description, avaliable, true, types);
        }
      ),
    );
  }
}

String title_parser(String description){
  description = description.replaceAll("Ãa", "i");
  description = description.replaceAll("Ã", "à");
  description = description.replaceAll("àa", "ia");
  description = description.replaceAll("Ã³", "ó");
  description = description.replaceAll("à³", "ó");
  description = description.replaceAll("Ã²", "ò");
  description = description.replaceAll("à²", "ò");
  description = description.replaceAll("Ã§", "ç");
  description = description.replaceAll("à§", "ç");
  description = description.replaceAll("Ã©", "é");
  description = description.replaceAll("à¨", "è");
  description = description.replaceAll("à©", "è");
  description = description.replaceAll("2 -", "2\n");
  description = description.replaceAll("6 -  ", "6\n");
  description = description.replaceAll("³-", "\n");
  description = description.replaceAll("er-Al", "er\nAl");
  description = description.replaceAll("a-Ca", "a\nCa");
  description = description.replaceAll(", Ap", "\nAp");
  description = description.replaceAll("-Ca", "\nCa");
  description = description.replaceAll(", Ca", "\nCa");
  description = description.replaceAll(" QR", "\nQR");
  description = description.replaceAll("37 - S", "37\nS");
  description = description.replaceAll("res SO", "res\nSO");
  description = description.replaceAll("-Ca", "\nCa");
  description = description.replaceAll("ó-Pl", "ó\nPl");
  description = description.replaceAll("mans i ", "mans\ni ");
  description = description.replaceAll("T-I", "T\nI");
  description = description.replaceAll("A  Torr", "A\nTorr");
  description = description.replaceAll("Mont-Roig", "Mont\nRoig");
  description = description.replaceAll("a Sup", "a\nSup");
  description = description.replaceAll("Despà", "Despí");
  if (description.length >= 40){
    description = description.replaceAll(" - ", "\n");
    //description = description.replaceAll("-", "\n");
    description = description.replaceAll("- ", "\n");
    description = description.replaceAll(")(", ")\n(");
    description = description.replaceAll(" (", "\n(");
    description = description.replaceAll("E L'", "E\nL'");
  }
  if (description.length < 40){
    description = description.replaceAll(") ", ")\n");
    description = description.replaceAll(" (", "\n(");
    description = description.replaceAll("m-", "m\n");
  }
  return description;
}


//funcion respectiva a la card de los cargadores
Widget _cardChargerList(String direction, bool avaliable, bool match, int types){

  //Generación rate aleatoria (harcode rate)
  Random random = Random();
  int min = 2, max = 6;
  int num = (min + random.nextInt(max - min));
  double numd = num.toDouble();

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
      width: 450,
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
                  child:  StarsStaticRateWidget(rate: numd),
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
            children:const [
              Padding(
                padding:EdgeInsets.only(right: 25),
                child: ImageChargerWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0),
                child: ButtonRouteWidget(latitude: 41.3874, longitude: 2.1686),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
