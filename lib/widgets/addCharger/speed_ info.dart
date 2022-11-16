import 'package:flutter/material.dart';
import 'package:greenwheel/services/private_chargers.dart';
import '../../serializers/chargers.dart';

class SpeedInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;
  final Function prevPage;
  SpeedInfo({Key? key, required this.data, required this.callback, required this.nextPage, required this.prevPage}) : super(key: key);

  @override
  State<SpeedInfo> createState() => _SpeedInfoState();
}

class _SpeedInfoState extends State<SpeedInfo> {

  var _speeds = [];
  var _selected_speeds = [];
  var i = 0;
  @override
  Widget build(BuildContext context) {
    if (_speeds.isEmpty && i == 0) {
      ++i;
      PrivateChargersService.getSpeeds().then((value) {
        setState(() {
          _speeds = value;
        });
      });
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: _speeds
                  .map((item) => CheckboxListTile(
                title: Text(item.name),
                value: _selected_speeds!.contains(item.name),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true &&
                        !_selected_speeds.contains(item.name)) {
                      _selected_speeds.add(item.name);
                    } else if (value == false && _selected_speeds.contains(item.name)) {
                      _selected_speeds.remove(item.name);
                    }
                    widget.data["speed"] = _selected_speeds;
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
                      widget.prevPage();
                    },
                    child: const Text('Previous'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      widget.callback(widget.data);
                      widget.nextPage();
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
