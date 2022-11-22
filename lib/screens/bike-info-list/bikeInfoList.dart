import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/backendServices/bikes.dart';
import '../../widgets/bike_card_info.dart';
import '../../widgets/infinite_list.dart';

class BikeInfoList extends StatefulWidget {
  const BikeInfoList({Key? key}) : super(key: key);

  @override
  State<BikeInfoList> createState() => _BikeInfoListState();

}

void main(){
  runApp(const MaterialApp(
    title: 'BikeInfo try',
    home: Scaffold(
      body: BikeInfoList(),
    ),
  ));
}

class _BikeInfoListState extends State<BikeInfoList>{

  List markersList = [];
  /*
  @override
  void initState(){
    super.initState();
    _getBikesList();
  }

  void _getBikesList() async {
    List? BikeList = await BikeService.getBikeList(pag); // es canviarà a bikes quan estiguin des de backend
    setState(() {
      if (BikeList != null) {
        markersList = BikeList;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bikes'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 125.0, left: 5.0),
            child: Icon(Icons.directions_bike_outlined),
          ),
        ],backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/');
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

            bool match = true;

            return _cardBikeList(description, avaliable, match, types);
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
Widget _cardBikeList(String direction, bool available, bool match, int types){
  //Generación rate aleatoria (harcode rate)
  Random random = Random();
  int min = 2, max = 6;
  int num = (min + random.nextInt(max - min));
  double numd = num.toDouble();

  return BikeCardInfoWidget(location: direction, rating: numd, types: types, available: available, match: match);
}
