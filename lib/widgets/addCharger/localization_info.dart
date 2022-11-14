import 'package:flutter/material.dart';


class LocalizationInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;
  final Function prevPage;
  LocalizationInfo({Key? key, required this.data, required this.callback, required this.nextPage, required this.prevPage}) : super(key: key);

  @override
  State<LocalizationInfo> createState() => _LocalizationInfoState();
}

class _LocalizationInfoState extends State<LocalizationInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Address"),
                    TextFormField(
                      initialValue: widget.data['direction'],
                      onSaved: (value) {
                        widget.data['direction'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                      initialValue: widget.data['town'],
                      onSaved: (value) {
                        widget.data['town'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                            initialValue: widget.data['lat'],
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              widget.data['lat'] = value!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
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
                            initialValue: widget.data['lng'],
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              widget.data['lng'] = value!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
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
                                widget.nextPage();
                              }
                            },
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ));
  }
}
