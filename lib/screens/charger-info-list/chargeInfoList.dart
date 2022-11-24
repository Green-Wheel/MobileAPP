import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chargers.dart';
import 'package:greenwheel/widgets/card_info.dart';

import '../../services/backendServices/chargers.dart';
import '../../widgets/infinite_list.dart';

class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}

void main(){
  runApp(const MaterialApp(
    title: 'chargeInfo try',
    home: Scaffold(
      body: ChargeInfoList(),
    ),
  ));
}

class _ChargeInfoListState extends State<ChargeInfoList>{
  List markersList = [];

  /*@override
  void initState(){
    super.initState();
    _getChargersList();
  }

  void _getChargersList() async {
    List chargerList = await ChargerService.getChargerList(1);
    print(chargerList);
    setState(() {
      markersList = chargerList;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargers'),
        centerTitle: true,
        actions: const [
        Padding(
          padding: EdgeInsets.only(right: 125.0, left: 5.0),
          child: Icon(Icons.location_on_outlined),
          ),
        ],backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).go('/');
          },
        ),
      ),
      body: InfiniteList(),
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
Widget _cardChargerList(String direction, bool avaliable, bool match, List<ConnectionType> types){
  //Generación rate aleatoria (harcode rate)
  Random random = Random();
  int min = 2, max = 6;
  int num = (min + random.nextInt(max - min));
  double numd = num.toDouble();

  return CardInfoWidget(location: direction, rating: numd, types: types, available: avaliable, match: match);
}
