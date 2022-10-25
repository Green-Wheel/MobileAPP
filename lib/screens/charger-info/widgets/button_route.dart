import 'package:flutter/material.dart';

class ButtonRouteWidget extends StatefulWidget {
  const ButtonRouteWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonRouteWidget();
}

class _ButtonRouteWidget extends State<ButtonRouteWidget>{
  @override
  Widget build(BuildContext context) {
    return _buttonRoute1();
  }
}


/*Widget _buttonRoute(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blueAccent, // foreground
      ),
      onPressed:() {},
      child:  Row(
        children: const [
          Text('Route ',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
          ),
          Icon(
            Icons.turn_slight_right_rounded,
            size: 20,
            color: Colors.blueAccent,
          ),
        ],
      ),
    ),
  );
}*/
//funcion del boton route situado en la card
Widget _buttonRoute1(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
    child: SizedBox(
      height: 33,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen[50]!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.green)
                )
            )
        ),
        onPressed:() {},
        child: Row(
          children: const [
            Text('Route ',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.lightGreen),
            ),
            Icon(
                Icons.directions,
                size: 18,
                color: Colors.green,
            ),
          ],
        ),
      ),
    ),
  );
}