import 'package:flutter/material.dart';

import '../serializers/chargers.dart';

class PointOfChargeDistWidget extends StatefulWidget {
  List<ConnectionType> types;
  PointOfChargeDistWidget({required this.types, super.key});

  @override
  State<StatefulWidget> createState() => _PointOfChargeDistWidget();
}

class _PointOfChargeDistWidget extends State<PointOfChargeDistWidget>{
  @override
  Widget build(BuildContext context) {
    return _pointOfCharge(widget.types);
  }
}

//funcion para mostrar información del cargador en la card (consultar al grupo)
Widget _pointOfCharge(List<ConnectionType> types){
  List<String> typesNames = [];
  for (int i = 0; i < types.length; ++i) {
    typesNames.add(types[i].name);
  }
  var stringList = typesNames.join(", ");
  return  Padding(
    padding: const EdgeInsets.only(left: 0.0, bottom: 3.5),
    child: Row(
      children: [
        Flexible(
            child: Text('Type/s of charger:  $stringList',
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color.fromRGBO(69, 69, 69, 1)),
            ),
        )
      ],
    ),
  );
}
