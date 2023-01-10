import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BatterySelector extends StatefulWidget {
  var selected_car;
  var user_cars;
  final Function callbackBattery;
  final Function callbackCar;

  BatterySelector(
      {Key? key,
      required this.selected_car,
      required this.user_cars,
      required this.callbackBattery,
      required this.callbackCar})
      : super(key: key);

  @override
  State<BatterySelector> createState() => _BatterySelectorState();
}

class _BatterySelectorState extends State<BatterySelector> {
  int battery = -1;

  @override
  Widget build(BuildContext context) {
    print('selected_car');
    print('selected_Car ${widget.user_cars}');
    return Column(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Column(
                  children: [
                    Container(
                      child: const Text('Sel·leciona el teu cotxe'),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton(
                        value: widget.selected_car,
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: widget.user_cars
                            .map<DropdownMenuItem<Object>>((value) {
                          return DropdownMenuItem(
                            value: value.id,
                            child: Text(value.alias),
                          );
                        }).toList() as List<DropdownMenuItem<Object>>,
                        onChanged: (value) {
                          widget.callbackCar(widget.user_cars
                              .firstWhere((element) => element.id == value));
                          setState(() {
                            widget.selected_car = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Column(
                  children: [
                    Container(
                      child: const Text('Sel·leciona la bateria'),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => widget.callbackBattery(value),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
