import 'package:flutter/material.dart';

class AvaliablePublicChargerWidget extends StatefulWidget {
  final bool avaliable;
  const AvaliablePublicChargerWidget({required this.avaliable, super.key});

  @override
  State<StatefulWidget> createState() => _AvaliablePublicChargerWidget();
}

class _AvaliablePublicChargerWidget extends State<AvaliablePublicChargerWidget>{
  late bool avaliable = false;
  @override
  Widget build(BuildContext context) {
    return _avaliablePublicCharger(avaliable);
  }
}

//funcion para determinar si un cargador publico esta disponible
Widget _avaliablePublicCharger(bool avaliable){
  if (avaliable){
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, bottom: 4.0),
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
      padding: const EdgeInsets.only(left: 0.0, bottom: 4.0),
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