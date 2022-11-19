import 'package:flutter/material.dart';

class AvaliableBikeWidget extends StatefulWidget {
  bool avaliable;
  AvaliableBikeWidget({required this.avaliable, super.key});

  @override
  State<StatefulWidget> createState() => _AvaliableBikeWidget();
}

class _AvaliableBikeWidget extends State<AvaliableBikeWidget>{
  @override
  Widget build(BuildContext context) {
    return _avaliableBike(widget.avaliable);
  }
}

//funcion para determinar si un cargador publico esta disponible
Widget _avaliableBike(bool avaliable){
  if (avaliable){
    return Padding(
      padding: const EdgeInsets.only(right: 0.0, bottom: 4.0),
      child: Row(
        children:const [
          Text('Available',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
          ),
        ],
      ),
    );
  }
  else {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0, bottom: 4.0),
      child: Row(
        children:const [
          Text('Not Available',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
          ),
        ],
      ),
    );
  }
}