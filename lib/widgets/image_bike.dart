import 'package:flutter/material.dart';

class ImageBikeWidget extends StatefulWidget {
  const ImageBikeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ImageBikeWidget();
}

class _ImageBikeWidget extends State<ImageBikeWidget>{
  @override
  Widget build(BuildContext context) {
    return _imageGreenWheelBike();
  }
}

//funcion para mostrar la imagen del marcador de Green Wheel en la card
Widget _imageGreenWheelBike(){
  return  Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
      //padding: const EdgeInsets.fromLTRB(30, 20, 10, 3),
      child: SizedBox(
        height: 90.0,
        child: Image.asset("assets/images/punt_bicicleta.png"),
      )
  );
}