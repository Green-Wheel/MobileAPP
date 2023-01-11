import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonReservaListBikeWidget extends StatefulWidget {
  int? id;
  ButtonReservaListBikeWidget(
      {super.key, });//required this.id}); //required this.id

  @override
  State<StatefulWidget> createState() => _ButtonReservaListBikeWidget();
}

class _ButtonReservaListBikeWidget extends State<ButtonReservaListBikeWidget>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 63,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.blue)))),
          onPressed: () {
            GoRouter.of(context)
                .go('/bookings/${widget.id}');
          },
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Text(
                  'Go Bookings',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child:Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

