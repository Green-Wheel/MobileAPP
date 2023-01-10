import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/vehicles/vehicles.dart';
import 'package:greenwheel/services/backendServices/vehicles.dart';

import '../serializers/users.dart';
import '../serializers/vehicles.dart';
import '../services/backendServices/user_service.dart';
import '../services/generalServices/LoginService.dart';

class CarCard extends StatefulWidget {
  Car car;
  User? logUser;
  Function callSetState;

  CarCard({required this.car, required this.logUser, required this.callSetState, super.key});

  @override
  State<StatefulWidget> createState() => _CarCardWidget();
}

bool isVisible = true;

class _CarCardWidget extends State<CarCard> {
  bool visible = true;
  late bool selected;

  void _showAvisEliminarVehicle() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete vehicle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete vehicle?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isVisible = true;
                });
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                if (selected) {
                  seleccionarVehicle(widget.car.id, true);
                }
                VehicleService.deleteVehicle(widget.car.id);
                Navigator.of(context).pop();
                setState(() {
                  isVisible = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> seleccionarVehicle(int? selected_car, bool toNull) async {
    await VehicleService.selectVehicle(selected_car, toNull);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('data: ${widget.logUser?.selected_car}');
    if (widget.logUser?.selected_car == null) {
      selected = false;
    } else {
      selected = widget.logUser?.selected_car == widget.car.id;
    }

    return Visibility(
        visible: isVisible,
        child: Center(
          child: Card(
            elevation: 7,
            color: Colors.white,
            shadowColor: Colors.black,
            margin: const EdgeInsets.all(10),
            shape: selected ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  color: Colors.green,
                  width: 3.0,
                )) : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[50],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Icon(Icons.directions_car, color: Colors.green),
                    ),
                    title: Text(widget.car.alias),
                    subtitle: Text('Brand: ${widget.car.car_brand.name}'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<
                                  Color>(Colors.blue[50]!),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18.0),
                                      side: const BorderSide(
                                          color: Colors.blue)
                                  )
                              )
                          ),
                          onPressed: () {
                            GoRouter.of(context).go('/vehicle/edit/${widget.car.id}');
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.edit, color: Colors.blue, size: 15),
                              Text('Edit',
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    selected ? Padding(
                      padding: EdgeInsets.only(right: width*0.06, left: width*0.06),
                      child: const Text('Selected',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ) :
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                      SizedBox(
                        height: 30,
                        width: 100,
                        child:
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<
                                  Color>(Colors.green[50]!),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18.0),
                                      side: const BorderSide(
                                          color: Colors.green)
                                  )
                              )
                          ),
                          onPressed: () {
                            seleccionarVehicle(widget.car.id, false);
                            widget.callSetState();
                          },
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text('Select',
                                style: TextStyle(fontWeight: FontWeight.w900,
                                    color: Colors.green),
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    selected ? const Padding(padding: EdgeInsets.only(bottom: 10, left: 30, right: 30)) :
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                      SizedBox(
                        height: 30,
                        child:
                        TextButton(
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
                            _showAvisEliminarVehicle();
                            if (!visible) {
                               isVisible = false;
                            }

                          },
                          child: Row(
                            children: const [
                              Icon(Icons.delete, color: Colors.red, size: 15),
                              Text('Delete',
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        )
      );
    }
  }
