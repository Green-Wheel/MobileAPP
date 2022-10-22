import 'package:flutter/material.dart';

class LocationChargerWidget extends StatefulWidget {
  final String location;
  const LocationChargerWidget({required this.location, super.key});

  @override
  State<StatefulWidget> createState() => _LocationChargerWidget();
}

class _LocationChargerWidget extends State<LocationChargerWidget>{
  String location = "location";

  @override
  Widget build(BuildContext context) {
    return _locationCharger(location);
  }
}

//funcion para mostrar la direccion del cargador en la card
Widget _locationCharger(String location){
  return Padding(
    padding: const EdgeInsets.only(left:0.0, bottom: 3.0, top: 20.0) ,
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
