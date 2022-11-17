import 'package:flutter/material.dart';
import '../../services/private_chargers.dart';

class CurrentInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function prevPage;

  CurrentInfo(
      {Key? key,
      required this.data,
      required this.callback,
      required this.prevPage})
      : super(key: key);

  @override
  State<CurrentInfo> createState() => _CurrentInfoState();
}

class _CurrentInfoState extends State<CurrentInfo> {
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
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Column(
          children: _current_types
              .map((item) => CheckboxListTile(
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
                  widget.callback(widget.data);
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
