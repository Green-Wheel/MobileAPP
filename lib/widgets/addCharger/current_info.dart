import 'package:flutter/material.dart';
import '../../services/backendServices/private_chargers.dart';

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
  void initState() {
    super.initState();
    _getCurrents();
    _selected_current_types = widget.data["current_type"];
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 50),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text("Power"),
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
                  ),
                  Column(
                    children: _current_types
                        .map((item) =>
                        CheckboxListTile(
                          title: Text(item.name),
                          value: _selected_current_types!.contains(item.id),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true &&
                                  !_selected_current_types.contains(item.id)) {
                                _selected_current_types.add(item.id);
                              } else if (value == false &&
                                  _selected_current_types.contains(item.id)) {
                                _selected_current_types.remove(item.id);
                              }
                              widget.data["current_type"] = _selected_current_types;
                            });
                          },
                        ))
                        .toList(),
                  )
                ],
              ),
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
