import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/select_image.dart';
import 'package:greenwheel/services/backend_service.dart';


class charger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
        MaterialApp(
          title: 'addCharger try',
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Formulary'),
            ),
            body: const AddCharger(),
          ),
        ));
  }
}


class AddCharger extends StatefulWidget {
  const AddCharger({Key? key}) : super(key: key);

  @override
  State<AddCharger> createState() => _AddChargerState();
}

typedef void SetImages(images);

class _AddChargerState extends State<AddCharger> {
  final _formKey0 = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  int _page = 0;

  var _data = {
    'title': '',
    'description': '',
    'direction': '',
    'town': '',
    'Latitude': '',
    'Longitude': '',
    'price': '',
    'power': '',
    'speed': [],
    'connection_type': [],
    'current_type': []
  };

  var _speeds = [];
  var _selected_speeds = [];
  var _connection_types = [];
  var _selected_connection_types = [];
  var _current_types = [];
  var _selected_current_types = [];

  var _images = [];

  void _getImage_data(images) {
    setState(() {
      _images = images;
    });
  }

  bool send_data() {
    BackendService.post('chargers/private/', _data).then((response) async {
      if (response.statusCode == 200) {
        print('Charger added');
        return true;
      } else {
        print('Charger not added');
        print(response.statusCode);
        return false;
      }
    });
    return false;
  }

  void getSpeeds() {
    BackendService.get('chargers/speed/').then((response) async {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          _speeds = json;
        });
      } else {
        print('Error getting speeds');
        print(response.statusCode);
      }
    });
  }

  void getConnectionTypes() {
    BackendService.get('chargers/connection/').then((response) async {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          _connection_types = json;
        });
      } else {
        print('Error getting connection types');
        print(response.statusCode);
      }
    });
  }

  void getCurrentTypes() {
    BackendService.get('chargers/current/').then((response) async {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          _current_types = json;
        });
      } else {
        print('Error getting current types');
        print(response.statusCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 0: {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
              child: Form(
                key: _formKey0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) {
                        _data['title'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onSaved: (value) {
                        _data['description'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _data['price'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _data['price'] = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    SelectImage(
                      multiple: true,
                      getImageData: _getImage_data,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey0.currentState!.validate()) {
                            _formKey0.currentState!.save();
                            setState(() {
                              ++_page;
                            });
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      case 1: {
        return SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) {
                      _data['direction'] = value!;
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
                      _data['town'] = value!;
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
                            _data['Latitude'] = value!;
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
                            _data['Longitude'] = value!;
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
                              --_page;
                            });
                          },
                          child: const Text('Previous'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              _formKey1.currentState!.save();
                              setState(() {
                                ++_page;
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
        );
      }
      case 2: {
        if(_speeds.isEmpty) {
          getSpeeds();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: _speeds.map((item) => CheckboxListTile(
                  title: Text(item["name"]),
                  value: _selected_speeds!.contains(item["name"]),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true && !_selected_speeds.contains(item["name"])) {
                        _selected_speeds.add(item["name"]);
                      } else if (value == false && _selected_speeds.contains(item["name"])) {
                        _selected_speeds.remove(item["name"]);
                      }
                      _data["speed"] = _selected_speeds;
                    });
                  },
                )).toList(),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          --_page;
                        });
                      },
                      child: const Text('Previous'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ++_page;
                        });
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ]),
        );
      }
      case 3: {
        if(_connection_types.isEmpty) {
          getConnectionTypes();
          print (_connection_types);
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: _connection_types.map((item) => CheckboxListTile(
                  title: Text(item["name"]),
                  value: _selected_connection_types!.contains(item["name"]),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true && !_selected_connection_types.contains(item["name"])) {
                        _selected_connection_types.add(item["name"]);
                      } else if (value == false && _selected_connection_types.contains(item["name"])) {
                        _selected_connection_types.remove(item["name"]);
                      }
                      _data["connection_type"] =_selected_connection_types;
                    });
                  },
                )).toList(),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          --_page;
                        });
                      },
                      child: const Text('Previous'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ++_page;
                        });
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ]),
        );
      }
      case 4: {
        if(_current_types.isEmpty) {
          getCurrentTypes();
          print (_current_types);
        }
        return SingleChildScrollView(
          child: Column(
              children: [
                Column(
                  children: _current_types.map((item) => CheckboxListTile(
                    title: Text(item["name"]),
                    value: _selected_current_types!.contains(item["name"]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true && !_selected_current_types.contains(item["name"])) {
                          _selected_current_types.add(item["name"]);
                        } else if (value == false && _selected_current_types.contains(item["name"])) {
                          _selected_current_types.remove(item["name"]);
                        }
                        _data["current_type"] = _selected_current_types;
                      });
                    },
                  )).toList(),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            --_page;
                          });
                        },
                        child: const Text('Previous'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          send_data();
                          print(_data);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ]),
        );
      }
      default: {
        return  Center(
          child: SingleChildScrollView(
            child: Text("PAGE NOT EXISTENT")
          ),
        );
      }
    }
  }
}