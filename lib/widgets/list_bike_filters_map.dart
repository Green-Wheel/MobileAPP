import 'package:flutter/material.dart';

class ListBikeFilterMap extends StatefulWidget {
  Function functionNormal;
  Function functionElectric;
  Function functionAll;
  Function functionProximity;
  Function functionDate;

  ListBikeFilterMap({required this.functionNormal,
    required this.functionElectric, required this.functionAll,
    required this.functionProximity, required this.functionDate, super.key});

  @override
  State<StatefulWidget> createState() => _ListBikeFilterMapWidget();
}

class _ListBikeFilterMapWidget extends State<ListBikeFilterMap> {
  bool pressFilterProximity = false;
  bool pressFilterDate = false;
  bool pressFilterNormal = false;
  bool pressFilterElectric = false;

  @override
  Widget build(BuildContext context) {
    return _ListBikeFilterMap();
  }

  Widget _ListBikeFilterMap() {
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
                        backgroundColor: pressFilterNormal ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterNormal = !pressFilterNormal;
                        pressFilterElectric = false;
                        pressFilterDate = false;
                        pressFilterProximity = false;
                      });
                      if (pressFilterNormal) {
                        widget.functionNormal(1);
                      } else {
                        widget.functionAll(1);
                      }
                    },
                    child: Row(
                      children: [
                        Text('Normal ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterNormal ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.pedal_bike,
                          size: 20,
                          color: pressFilterNormal ? Colors.blue : Colors.grey[700]!,
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
                        backgroundColor: pressFilterElectric ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterElectric = !pressFilterElectric;
                        pressFilterNormal = false;
                        pressFilterDate = false;
                        pressFilterProximity = false;
                      });
                      if (pressFilterElectric) {
                        widget.functionElectric(1);
                      } else {
                        widget.functionAll(1);
                      }
                    },
                    child: Row(
                      children: [
                        Text('Electric ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pressFilterElectric ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.electric_bike,
                          size: 20,
                          color: pressFilterElectric ? Colors.blue : Colors.grey[700]!,
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
                        backgroundColor: pressFilterProximity ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterProximity = !pressFilterProximity;
                        pressFilterElectric = false;
                        pressFilterNormal = false;
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
                              color: pressFilterProximity ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.gps_fixed,
                          size: 20,
                          color: pressFilterProximity ? Colors.blue : Colors.grey[700]!,
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
                        backgroundColor: pressFilterDate ? MaterialStateProperty.all<Color>(Colors.blue[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    onPressed:() {
                      setState(() {
                        pressFilterDate = !pressFilterDate;
                        pressFilterElectric = false;
                        pressFilterNormal = false;
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
                              color: pressFilterDate ? Colors.blue : Colors.grey[700]!),
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: pressFilterDate ? Colors.blue : Colors.grey[700]!,
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