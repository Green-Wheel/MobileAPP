import 'package:flutter/material.dart';
import '../../services/private_chargers.dart';

class CurrentInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function prevPage;

  CurrentInfo({Key? key,
    required this.data,
    required this.callback,
    required this.prevPage})
      : super(key: key);

  @override
  State<CurrentInfo> createState() => _CurrentInfoState();
}

class _CurrentInfoState extends State<CurrentInfo> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _current_types = [];
  var _selected_current_types = [];

  void _getCurrents() async {
    List<dynamic> currentsL = await PrivateChargersService.getCurrentTypes();
    setState(() {
      _current_types = currentsL;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_current_types.isEmpty) {
      _getCurrents();
      _selected_current_types = widget.data["current"];
    }
      return Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  Column(
                    children: _current_types
                        .map((item) =>
                        CheckboxListTile(
                          title: Text(item.name),
                          value: _selected_current_types!.contains(item.name),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true &&
                                  !_selected_current_types.contains(item.name)) {
                                _selected_current_types.add(item.name);
                              } else if (value == false &&
                                  _selected_current_types.contains(item.name)) {
                                _selected_current_types.remove(item.name);
                              }
                              widget.data["current_type"] = _selected_current_types;
                            });
                          },
                        ))
                        .toList(),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text("power"),
                        TextFormField(
                          initialValue: widget.data['power'],
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            widget.data['power'] = value!;
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
                      ]
                    )
                  )
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.prevPage();
                      },
                      child: const Text('Previous'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.callback(widget.data);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ]),
          ));
    }
  }
