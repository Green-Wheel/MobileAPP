import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonReservaListWidget extends StatefulWidget {

  const ButtonReservaListWidget(
      {super.key});

  @override
  State<StatefulWidget> createState() => _ButtonReservaListWidget();
}

class _ButtonReservaListWidget extends State<ButtonReservaListWidget>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.lightGreen[50]!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.green)))),
        onPressed: () {
          GoRouter.of(context)
              .go('/bookings/');
        },
        child: Row(
          children: const [
            Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
                'Go Bookings',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.lightGreen),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child:Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.green,
                ),
            ),
          ],
        ),
      ),
    );
  }
}

