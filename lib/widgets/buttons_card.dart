import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'reservation_charger_card.dart';

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
                    GoRouter.of(context).go('/route/${widget.longitude}/${widget.latitude}');
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
                  BookingService.deleteBookings(widget.id);
                  widget.function();
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
