import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonBlueRouteWidget extends StatefulWidget {
  final longitude;
  final latitude;

  const ButtonBlueRouteWidget(
      {super.key, required this.longitude, required this.latitude});

  @override
  State<StatefulWidget> createState() => _ButtonBlueRouteWidget();
}

class _ButtonBlueRouteWidget extends State<ButtonBlueRouteWidget>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
      child: SizedBox(
        height: 33,
        width: 70,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.lightBlue[50]!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.blue)))),
          onPressed: () {
            GoRouter.of(context)
                .go('/route/${widget.longitude}/${widget.latitude}');
          },
          child: Row(
            children: const [
              Text(
                'Route ',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.lightBlue),
              ),
              Icon(
                Icons.directions,
                size: 18,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
