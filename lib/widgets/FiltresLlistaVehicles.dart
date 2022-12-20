import 'package:flutter/material.dart';
import '../screens/vehicles/vehicles.dart';
import '../serializers/vehicles.dart';
import '../services/backendServices/vehicles.dart';

class FiltresLlistaVehicles extends StatefulWidget {
  List<Vehicle> vehicles;

  FiltresLlistaVehicles({required this.vehicles, super.key});

  @override
  State<StatefulWidget> createState() => _FiltresLlistaVehiclesWidget();
}

class _FiltresLlistaVehiclesWidget extends State<FiltresLlistaVehicles> {
  bool pressFilterByCars = false;
  bool pressFilterByBikes = false;
  bool disableCharger = true;
  bool disableBike = true;
  List<Vehicle> listVehicles = [];

  @override
  Widget build(BuildContext context) {
    return _filtresLlistaVehicles(widget.vehicles);
  }

  void _getAllVehicles() async {
    List<Vehicle> vehicleList = await VehicleService.getVehicles();
    setState(() {
      widget.vehicles = vehicleList;
    });
  }

  void _getCars() async {
    List<Vehicle> carList = await VehicleService.getCars();
    setState(() {
      widget.vehicles = carList;
    });
  }

  void _getBikes() async {
    List<Vehicle> bikeList = await VehicleService.getBikes();
    setState(() {
      widget.vehicles = bikeList;
    });
  }

  Widget _filtresLlistaVehicles(List<dynamic>? vehicles) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 7.5, bottom: 1),
                child: SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: pressFilterByCars ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.5),
                                side: BorderSide(
                                    color: pressFilterByCars ? Colors.green : Colors.grey[700]!)
                            )
                        )
                    ),
                    onPressed: disableCharger ? () {
                      setState(() {
                        pressFilterByCars = !pressFilterByCars;
                        disableBike = !disableBike;
                      });
                      if (pressFilterByCars) {
                        _getCars();
                      } else {
                        _getAllVehicles();
                      }
                    } : null,
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          size: 20,
                          color: pressFilterByCars ? Colors.green : Colors.grey[700]!,
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
                        backgroundColor: pressFilterByBikes ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    7.5),
                                side: BorderSide(
                                    color: pressFilterByBikes ? Colors.green : Colors.grey[700]!)
                            )
                        )
                    ),
                    onPressed: disableBike ? () {
                      setState(() {
                        pressFilterByBikes = !pressFilterByBikes;
                        disableCharger = !disableCharger;
                      });
                      if (pressFilterByBikes) {
                        _getBikes();
                      } else {
                        _getAllVehicles();
                      }
                    } : null,
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_bike,
                          size: 20,
                          color: pressFilterByBikes ? Colors.green : Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: buildList(widget.vehicles),
        ),
      ],
    );
  }
}