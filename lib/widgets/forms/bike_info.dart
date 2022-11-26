import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../serializers/bikes.dart';
import '../../services/backendServices/bikes.dart';

class BikeInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function prevPage;

  BikeInfo(
      {Key? key,
      required this.data,
      required this.callback,
      required this.prevPage})
      : super(key: key);

  @override
  State<BikeInfo> createState() => _BikeInfoState();
}

class _BikeInfoState extends State<BikeInfo> {
  List<BikeType> _bike_types = [];
  var _bike_name = [];
  var _selected = '';
  final _formKey = GlobalKey<FormState>();

  void _getBikeTypes() async {
    List<BikeType> bike_typesL = await BikeService.getBikeTypes();
    setState(() {
      _bike_types = bike_typesL;
      _bike_name = bike_typesL.map((e) => e.name).toList();
      _selected = widget.data['bike_type'].name != ''
          ? widget.data['bike_type'].name
          : _bike_name.first;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBikeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0),
        child: Column(
          children: [
            Container(
              width: 9 * MediaQuery.of(context).size.height / 10,
              child: DropdownButton(
                value: _selected,
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                items: _bike_name.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selected = value as String;
                  });
                },
              ),
            ),
            _selected == 'Electric'
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text("Power", textAlign: TextAlign.left),
                        TextFormField(
                          initialValue:
                              widget.data["power"].toString() != 'null'
                                  ? widget.data["power"].toString()
                                  : '',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              widget.data["power"] = double.parse(value);
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter Power';
                            }
                            return null;
                          },
                        ),
                      ],
                    ))
                : Container(),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.prevPage();
                    },
                    child: const Text('previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_selected != 'Electric' ||
                          (_selected == 'Electric' &&
                              _formKey.currentState!.validate())) {
                        widget.data["bike_type"] = _bike_types
                            .firstWhere((element) => element.name == _selected);
                        widget.callback(widget.data);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
