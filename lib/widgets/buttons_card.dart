import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/backendServices/bookings.dart';

class ButtonsCard extends StatefulWidget {
  int id;
  Function function;
  double longitude;
  double latitude;

  ButtonsCard({required this.function, required this.id, required this.longitude,
    required this.latitude, super.key});

  @override
  State<StatefulWidget> createState() => _ButtonsCard();
}

class _ButtonsCard extends State<ButtonsCard> {
  void _showAvisCancelarReserva() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to cancel booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                BookingService.deleteBookings(widget.id);
                widget.function();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: 30,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<
                          Color>(Colors.lightBlue[50]!),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  18.0),
                              side: const BorderSide(
                                  color: Colors.blueAccent)
                          )
                      )
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/route/${widget.longitude}/${widget.latitude}/-1');
                  },
                  child: Row(
                    children: const [
                      Text('Route ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      ),
                      Icon(
                        Icons.directions,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: 30,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<
                          Color>(Colors.lightBlue[50]!),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  18.0),
                              side: const BorderSide(
                                  color: Colors.blueAccent)
                          )
                      )
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('Chat ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      ),
                      Icon(
                        Icons.chat,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 30,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<
                        Color>(Colors.red[50]!),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                18.0),
                            side: const BorderSide(
                                color: Colors.red)
                        )
                    )
                ),
                onPressed: () {
                  _showAvisCancelarReserva();
                },
                child: Row(
                  children: const [
                    Text('Cancel ',
                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    Icon(
                      Icons.cancel,
                      size: 20,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
