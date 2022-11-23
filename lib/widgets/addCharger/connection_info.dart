import 'package:flutter/material.dart';
import '../../services/backendServices/private_chargers.dart';

class ConnectionInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  ConnectionInfo(
      {Key? key,
      required this.data,
      required this.callback,
      required this.nextPage,
      required this.prevPage})
      : super(key: key);

  @override
  State<ConnectionInfo> createState() => _ConnectionInfoState();
}

class _ConnectionInfoState extends State<ConnectionInfo> {
  List<dynamic> _connection_types = [];
  var _selected_connection_types = [];

  void _getConnections() async {
    List<dynamic> connectionsL =
        await PrivateChargersService.getConnectionTypes();
    setState(() {
      _connection_types = connectionsL;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connection_types.isEmpty) {
      _getConnections();
      _selected_connection_types = widget.data["connection_type"];
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Column(
          children: _connection_types
              .map((item) => CheckboxListTile(
                    title: Text(item.name),
                    value: _selected_connection_types!.contains(item.name),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true &&
                            !_selected_connection_types
                                .contains(item.name)) {
                          _selected_connection_types.add(item.name);
                        } else if (value == false &&
                            _selected_connection_types.contains(item.name)) {
                          _selected_connection_types.remove(item.name);
                        }
                        widget.data["connection_type"] =
                            _selected_connection_types;
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
