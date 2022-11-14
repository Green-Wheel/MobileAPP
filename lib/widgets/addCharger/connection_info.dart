import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/backend_service.dart';

class ConnectionInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;
  final Function prevPage;
  ConnectionInfo({
    super.key,
    required this.data,
    required this.callback,
    required this.nextPage,
    required this.prevPage}) {
    this.data['connection_type'] = data['connection_type'] ?? '';
  }

  @override
  State<ConnectionInfo> createState() => _ConnectionInfoState();
}

class _ConnectionInfoState extends State<ConnectionInfo> {
  var _connection_types = [];
  var _selected_connection_types = [];

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

  @override
  Widget build(BuildContext context) {
    if (_connection_types.isEmpty) {
      getConnectionTypes();
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: _connection_types
                  .map((item) => CheckboxListTile(
                title: Text(item["name"]),
                value: _selected_connection_types!
                    .contains(item["name"]),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true &&
                        !_selected_connection_types
                            .contains(item["name"])) {
                      _selected_connection_types.add(item["name"]);
                    } else if (value == false && _selected_connection_types.contains(item["name"])) {
                      _selected_connection_types.remove(item["name"]);
                    }
                    widget.data["connection_type"] =_selected_connection_types;
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
