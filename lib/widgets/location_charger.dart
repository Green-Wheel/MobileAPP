import 'package:flutter/material.dart';

class LocationChargerWidget extends StatefulWidget {
  String? location;
  LocationChargerWidget({required this.location, super.key});

  @override
  State<StatefulWidget> createState() => _LocationChargerWidget();
}

class _LocationChargerWidget extends State<LocationChargerWidget>{
  @override
  Widget build(BuildContext context) {
    return _locationCharger(widget.location);
  }
}

//funcion para mostrar la direccion del cargador en la card
Widget _locationCharger(String? location){
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0) ,
    child: Row(
      children: [
        Flexible(child:
          Text(location!,
              style: const TextStyle(fontWeight: FontWeight.w600)
          ),
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
