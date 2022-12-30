import 'package:flutter/material.dart';

import '../serializers/vehicles.dart';
import '../services/generalServices/LoginService.dart';

class CarCard extends StatefulWidget {
  Car car;

  CarCard({required this.car, super.key});

  @override
  State<StatefulWidget> createState() => _CarCardWidget();
}

class _CarCardWidget extends State<CarCard> {
  final _loggedInStateInfo = LoginService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isVisible = true;
    var data = _loggedInStateInfo.user_info;
    print(widget.car.id);
    bool selected;
    if (data!['selected_car'] == null) {
      selected = false;
    } else {
      selected = data['selected_car'] == widget.car.id;
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
                            // isVisible = false;
                            // route to edit screen
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
                            isVisible = false;
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
                            isVisible = false;
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
