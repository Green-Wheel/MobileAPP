import 'package:flutter/material.dart';

class PointOfChargeDistWidget extends StatefulWidget {
  final int distance;
  const PointOfChargeDistWidget({required this.distance, super.key});

  @override
  State<StatefulWidget> createState() => _PointOfChargeDistWidget();
}

class _PointOfChargeDistWidget extends State<PointOfChargeDistWidget>{
  late int distance = 2;

  @override
  Widget build(BuildContext context) {
    return _pointOfCharge(distance);
  }
}

//funcion para mostrar información del cargador en la card (consultar al grupo)
Widget _pointOfCharge(int distance){
  return  Padding(
    padding: const EdgeInsets.only(left: 0.0, bottom: 3.5),
    child: Row(
      children: [
        Text('Point of charge - ($distance km)',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
