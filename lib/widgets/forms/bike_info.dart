import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> _bike_types = [];
  final _formKey = GlobalKey<FormState>();

  void _getBikeTypes() {
    List<Map<String, dynamic>> bike_typesL = [
      {"name": "Electric"},
      {"name": "Hybrid"},
      {"name": "Gas"},
    ];
    setState(() {
      _bike_types = bike_typesL;
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
                value: widget.data["bike_type"]['name'],
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                items: _bike_types.map((item) {
                  return DropdownMenuItem(
                    value: item['name'],
                    child: Text(item["name"]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.data["bike_type"]['name'] = value;
                  });
                },
              ),
            ),
            widget.data["bike_type"]['name'] == 'Electric'
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text("Power", textAlign: TextAlign.left),
                        TextFormField(
                          initialValue: widget.data["power"],
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              widget.data["power"] = value;
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
                      if (widget.data["bike_type"]['name'] != 'Electric' ||
                          (widget.data["bike_type"]['name'] != 'Electric' &&
                              _formKey.currentState!.validate())) {
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
