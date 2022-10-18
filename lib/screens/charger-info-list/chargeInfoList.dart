import 'dart:core';
import 'dart:ffi';


import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      body: ListView.builder(
        itemCount: 25,
        itemBuilder: (context, position) {
          return Dismissible(
            key: Key(element[position]),
            child: _cardChargerList("location", true, true),
          );
        }
      ),
    );
  }
}

//funcion para mostrar la direccion del cargador en la card
Widget _locationCharger(String location){
  return Padding(
    padding: const EdgeInsets.only(left: 45.0, bottom: 3.0, top: 25.0) ,
    child: Row(
      children: [
        Text(location,
            style: const TextStyle(fontWeight: FontWeight.w600)
        ),
        Icon(
          Icons.bolt,
          size: 20,
          color: Colors.green[500],
        ),
      ],
    ),
  );
}

//funcion para mostrar información del cargador en la card (consultar al grupo)
Widget _pointOfCharge(){
  return  Padding(
    padding: const EdgeInsets.only(left: 48.0, bottom: 3.5),
    child: Row(
      children: [
        Text('Point of charge - ( km)',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

//funcion para mostrar la imagen del marcador de Green Wheel en la card
Widget _imageGreenWheelCharger(){
  return  Padding(
      padding: EdgeInsets.fromLTRB(25, 18, 5, 0),
      child: SizedBox(
        height: 90.0,
        child: Image.asset("assets/images/punt_carregador.png"),
      )
  );
}


//funcion del boton route situado en la card
Widget _bottonRoute(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(38, 0, 0, 0),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blueAccent, // foreground
      ),
      onPressed:() {},
      child:  Row(
        children: const [
          Text('Route ',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
          ),
          Icon(
            Icons.turn_slight_right_rounded,
            size: 20,
            color: Colors.blueAccent,
          ),
        ],
      ),
    ),
  );
}

//TODO: Preguntar por el no funcinamiento de la dependencia de star_bar

//funcion para mostrar las estrellas
/*Widget _starsStaticCard(double rate){
  return RatingBar.builder(
    initialRating: rate,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder:(context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    /*onRatingUpdate: (rating) {
      print(rating);
    },*/
  );
}*/

//funcion para determinar la compatibilidad cargador con el coche
Widget _matchCarWithCharger(bool match){
  if (match){
    return Padding(
        padding: const EdgeInsets.only(left: 42.0),
        child: Row(
        children: const [
          Icon (
            Icons.check_circle_outline_rounded,
            size: 20,
            color: Colors.green,
          ),
          Padding(
            padding:EdgeInsets.only(left: 5.0),
            child: Text('Matching with your car charger',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  else{
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Row(
        children: const [
          Icon (
            Icons.do_not_disturb_on_outlined,
            size: 20,
            color: Colors.red,
          ),
          Padding(
            padding:EdgeInsets.only(left: 5.0),
            child: Text('Not match with your car charger',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

//funcion para determinar si un cargador publico esta disponible
Widget _avaliablePublicCharger(bool avaliable){
  if (avaliable){
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 4.0),
      child: Row(
        children:const [
          Text('Available: ',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
          ),
          Text("time",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  else {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 4.0),
      child: Row(
        children:const [
          Text('Not Available: ',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
          ),
          Text("time",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
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
        width: 4,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: SizedBox(
      height: 162.5,
      child:Row(
        children: [
          Column(
            children: [
              _locationCharger(direction),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, bottom: 3.0),
                child: Row(
                  children: [
                    //_starsStaticCard(4.0),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("rating".toString(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              _pointOfCharge(),
              _avaliablePublicCharger(avaliable),
              _matchCarWithCharger(match),
            ],
          ),
          Column(
            children: [
              _imageGreenWheelCharger(),
              _bottonRoute(),
            ],
          ),
        ],
      ),
    ),
  );
}