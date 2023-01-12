import 'package:flutter/material.dart';

class BikeFilterMap extends StatefulWidget {
  Function functionNormal;
  Function functionElectric;
  Function functionAll;

  BikeFilterMap({required this.functionNormal, required this.functionElectric,
    required this.functionAll, super.key});

  @override
  State<StatefulWidget> createState() => _BikeFilterMapWidget();
}

class _BikeFilterMapWidget extends State<BikeFilterMap> {
  bool pressFilterCompatible = false;
  bool pressFilterPublic = false;
  bool pressFilterPrivate = false;

  @override
  Widget build(BuildContext context) {
    return _BikeFilterMap();
  }

  Widget _BikeFilterMap() {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 7.5, bottom: 1),
                child: SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor: pressFilterPublic ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
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
                      });
                      if (pressFilterPublic) {
                        widget.functionNormal();
                      } else {
                        widget.functionAll();
                      }
                    },
                    child: Row(
                      children: [
                        Text('Normal ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterPublic ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.pedal_bike,
                          size: 20,
                          color: pressFilterPublic ? Colors.blue : Colors.grey[700]!,
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
                        backgroundColor: pressFilterPrivate ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
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
                      });
                      if (pressFilterPrivate) {
                        widget.functionElectric();
                      } else {
                        widget.functionAll();
                      }
                    },
                    child: Row(
                      children: [
                        Text('Electric ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterPrivate ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.electric_bike,
                          size: 20,
                          color: pressFilterPrivate ? Colors.blue : Colors.grey[700]!,
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