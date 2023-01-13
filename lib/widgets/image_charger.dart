import 'package:flutter/material.dart';

class ImageChargerWidget extends StatefulWidget {
  const ImageChargerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ImageChargerWidget();
}

class _ImageChargerWidget extends State<ImageChargerWidget>{
  @override
  Widget build(BuildContext context) {
    return _imageGreenWheelCharger();
  }
}

//funcion para mostrar la imagen del marcador de Green Wheel en la card
Widget _imageGreenWheelCharger(){
  return SizedBox(
        height: 90.0,
        child: Image.asset("assets/images/punt_carregador.png"),
  );
}