import 'package:flutter/material.dart';

class ListChargerFilterMap extends StatefulWidget {
  Function functionPublic;
  Function functionPrivate;
  Function functionAll;
  Function functionProximity;
  Function functionDate;

  ListChargerFilterMap({required this.functionPublic,
    required this.functionPrivate, required this.functionAll,
    required this.functionProximity, required this.functionDate, super.key});

  @override
  State<StatefulWidget> createState() => _ListChargerFilterMapWidget();
}

class _ListChargerFilterMapWidget extends State<ListChargerFilterMap> {
  bool pressFilterProximity = false;
  bool pressFilterDate = false;
  bool pressFilterCompatible = false;
  bool pressFilterPublic = false;
  bool pressFilterPrivate = false;

  @override
  Widget build(BuildContext context) {
    return _ListChargerFilterMap();
  }

  Widget _ListChargerFilterMap() {
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
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: pressFilterProximity ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterProximity = !pressFilterProximity;
                        pressFilterPrivate = false;
                        pressFilterPublic = false;
                        pressFilterCompatible = false;
                        pressFilterDate = false;
                      });
                      if (pressFilterProximity) {
                        widget.functionProximity(1);
                      } else {
                        widget.functionAll(1);
                      }
                    },
                    child: Row(
                      children: [
                        Text('Proximity ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterProximity ? Colors.green : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.gps_fixed,
                          size: 20,
                          color: pressFilterProximity ? Colors.green : Colors.grey[700]!,
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
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor: pressFilterDate ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterDate = !pressFilterDate;
                        pressFilterPrivate = false;
                        pressFilterPublic = false;
                        pressFilterCompatible = false;
                        pressFilterProximity = false;
                      });
                      if (pressFilterDate) {
                        widget.functionDate(1);
                      } else {
                        widget.functionAll(1);
                      }
                    },
                    child: Row(
                      children: [
                        Text('Date ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterDate ? Colors.green : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: pressFilterDate ? Colors.green : Colors.grey[700]!,
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
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor: pressFilterCompatible ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterCompatible = !pressFilterCompatible;
                        pressFilterPrivate = false;
                        pressFilterPublic = false;
                        pressFilterDate = false;
                        pressFilterProximity = false;
                      });
                    },
                    child: Row(
                      children: [
                        Text('Compatible ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterCompatible ? Colors.green : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: pressFilterCompatible ? Colors.green : Colors.grey[700]!,
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
                        elevation: MaterialStateProperty.all(2),
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
                        pressFilterCompatible = false;
                        pressFilterDate = false;
                        pressFilterProximity = false;
                      });
                      if (pressFilterPublic) {
                        widget.functionPublic(1);
                      } else {
                        widget.functionAll(1);
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
                padding: const EdgeInsets.only(left: 10.0, right: 5, top: 7.5, bottom: 1),
                child: SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
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
                        pressFilterCompatible = false;
                        pressFilterDate = false;
                        pressFilterProximity = false;
                      });
                      if (pressFilterPrivate) {
                        widget.functionPrivate(1);
                      } else {
                        widget.functionAll(1);
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