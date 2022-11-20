import 'package:flutter/material.dart';

class PointOfChargeDistWidget extends StatefulWidget {
  int types;
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
Widget _pointOfCharge(int types){
  return  Padding(
    padding: const EdgeInsets.only(left: 0.0, bottom: 3.5),
    child: Row(
      children: [
        Text('Type/s of charger:  $types',
          style: const TextStyle(fontWeight: FontWeight.w500, color: Color.fromRGBO(69, 69, 69, 1)),
        ),
      ],
    ),
  );
}
