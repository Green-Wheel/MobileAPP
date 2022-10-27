import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonRouteWidget extends StatefulWidget {
  final longitude;
  final latitude;

  const ButtonRouteWidget(
      {super.key, required this.longitude, required this.latitude});

  @override
  State<StatefulWidget> createState() => _ButtonRouteWidget();
}

class _ButtonRouteWidget extends State<ButtonRouteWidget>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
      child: SizedBox(
        height: 33,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreen[50]!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.green)))),
          onPressed: () {
            GoRouter.of(context)
                .go('/route/${widget.longitude}/${widget.latitude}');
          },
          child: Row(
            children: const [
              Text(
                'Route ',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.lightGreen),
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