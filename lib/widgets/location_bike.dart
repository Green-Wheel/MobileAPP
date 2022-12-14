import 'package:flutter/material.dart';

class LocationBikeWidget extends StatefulWidget {
  String location;
  int? bikeType;
  LocationBikeWidget({required this.location, required this.bikeType, super.key});

  @override
  State<StatefulWidget> createState() => _LocationBikeWidget();
}

class _LocationBikeWidget extends State<LocationBikeWidget>{
  @override
  Widget build(BuildContext context) {
    return _locationBike(widget.location, widget.bikeType);
  }
}

//funcion para mostrar la direccion del cargador en la card
Widget _locationBike(String location, int? bikeType) {
  if (bikeType == 1) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 3.0, top: 20.0),
      child: Row(
        children: [
          Flexible(child:
          Text(location,
              style: const TextStyle(fontWeight: FontWeight.w600)
          ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(
              Icons.pedal_bike,
              size: 20,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    );
  } else if (bikeType == 2) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 3.0, top: 20.0),
      child: Row(
        children: [
          Flexible(child:
          Text(location,
              style: const TextStyle(fontWeight: FontWeight.w600)
          ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(
              Icons.electric_bike_outlined,
              size: 20,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    );
  } else { // null
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 3.0, top: 20.0),
      child: Row(
        children: [
          Flexible(child:
            Text(location,
                style: const TextStyle(fontWeight: FontWeight.w600)
            ),
          ),
        ],
      ),
    );
  }
}
