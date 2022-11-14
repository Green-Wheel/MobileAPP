import 'package:flutter/material.dart';


class LocalizationInfo extends StatefulWidget {
  var data;
  final Function callback;
  LocalizationInfo({super.key, required this.data, required this.callback}) {
    this.data['direction'] = data['direction'] ?? '';
    this.data['town'] = data['town'] ?? '';
    this.data['lat'] = data['lat'] ?? '';
    this.data['lng'] = data['lng'] ?? '';
  }
  @override
  State<LocalizationInfo> createState() => _LocalizationInfoState();
}

class _LocalizationInfoState extends State<LocalizationInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) {
                      widget.data['direction'] = value!;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Direction',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter Direction';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (value) {
                      widget.data['town'] = value!;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Town',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter Town';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            widget.data['Latitude'] = value!;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Latitude',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter Latitude';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            widget.data['Longitude'] = value!;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Longitude',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter Longitude';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                             // --_page;
                            });
                          },
                          child: const Text('Previous'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                //++_page;
                              });
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}
