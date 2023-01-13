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
  void initState() {
    super.initState();
    _getConnections();
    _selected_connection_types = widget.data["connection_type"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        const Text('Select connection types'),
        Column(
          children: _connection_types
              .map((item) => CheckboxListTile(
                    title: Text(item.name),
                    value: _selected_connection_types!.contains(item.id),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true &&
                            !_selected_connection_types.contains(item.id)) {
                          _selected_connection_types.add(item.id);
                        } else if (value == false &&
                            _selected_connection_types.contains(item.id)) {
                          _selected_connection_types.remove(item.id);
                        }
                        widget.data["connection_type"] =
                            _selected_connection_types;
                      });
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
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
