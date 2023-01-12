import 'package:flutter/material.dart';

class ChargerFilterMap extends StatefulWidget {
  Function functionPublic;
  Function functionPrivate;
  Function functionAll;

  ChargerFilterMap({required this.functionPublic, required this.functionPrivate,
    required this.functionAll, super.key});

  @override
  State<StatefulWidget> createState() => _ChargerFilterMapWidget();
}

class _ChargerFilterMapWidget extends State<ChargerFilterMap> {
  bool pressFilterPublic = false;
  bool pressFilterPrivate = false;

  @override
  Widget build(BuildContext context) {
    return _ChargerFilterMap();
  }

  Widget _ChargerFilterMap() {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                child: SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: pressFilterPublic ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterPublic = !pressFilterPublic;
                        pressFilterPrivate = false;
                      });
                      if (pressFilterPublic) {
                        widget.functionPublic();
                      } else {
                        widget.functionAll();
                      }
                    },
                    child: Row(
                      children: [
                        Text('Public ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterPublic ? Colors.green : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.bolt,
                          size: 20,
                          color: pressFilterPublic ? Colors.green : Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                child: SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor: pressFilterPrivate ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterPrivate = !pressFilterPrivate;
                        pressFilterPublic = false;
                      });
                      if (pressFilterPrivate) {
                        widget.functionPrivate();
                      } else {
                        widget.functionAll();
                      }
                    },
                    child: Row(
                      children: [
                        Text('Private ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterPrivate ? Colors.green : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.private_connectivity,
                          size: 20,
                          color: pressFilterPrivate ? Colors.green : Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}