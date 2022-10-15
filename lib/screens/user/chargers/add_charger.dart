import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/select_image.dart';
//import 'package:flutter_gen/gen_l10n/localizations.dart';

void main() {runApp(MaterialApp(
  title: 'addCharger try',
  home: Scaffold(
    appBar: AppBar(
      title: const Text('Formulary'),
    ),
    body: const AddCharger(),
  ),
));}


class AddCharger extends StatefulWidget {
  const AddCharger({Key? key}) : super(key: key);

  @override
  State<AddCharger> createState() => _AddChargerState();
}

typedef void SetImages(images);

class _AddChargerState extends State<AddCharger> {
  final _formKey = GlobalKey<FormState>();
  var data =  {
    'title': '',
    'description': '',
    'price': '',
    'power': '',
    'velocity': 'Normal',
    'Latitude': '',
    'Longitude': '',
    'tipusCarregador': '',
    'images': [],
  };

  void _getImageData(images) {
    data['images'] = images;
  }

  @override
  Widget build(BuildContext context) {
    //final tr = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  data['title'] = value!;
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
                  data['description'] = value!;
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        data['Latitude'] = value!;
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
                        data['Longitude'] = value!;
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
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  data['price'] = value!;
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
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  data['power'] = value!;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Power',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter power';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:0.0, horizontal: 8.0),
                child: DropdownButton(
                  isExpanded: true,
                  itemHeight: 60,
                  value: data['velocity'],
                  items: const <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text('Normal'),
                      value: 'Normal',
                    ),
                    DropdownMenuItem(
                      child: Text('Half Fast'),
                      value: 'Half-Fast',
                    ),
                    DropdownMenuItem(
                      child: Text('Fast'),
                      value: 'Fast',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => data['velocity'] = value.toString());
                  },
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  data['tipusCarregador'] = value!;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tipus carregador',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter Tipus carregador';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              SelectImage(
                  multiple: true,
                  getImageData: _getImageData,
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Form data is: '),
                            content: Text(data.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

