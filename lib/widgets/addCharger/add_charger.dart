import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/widgets/addCharger/connection_info.dart';
import 'package:greenwheel/widgets/addCharger/current_info.dart';
import 'package:greenwheel/widgets/addCharger/localization_info.dart';
import 'package:greenwheel/widgets/addCharger/speed_%20info.dart';
import 'package:greenwheel/widgets/addCharger/basic_info.dart';

import 'basic_info.dart';

class charger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
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

  int _page = 1;

  List<File> _images = [];

  var _data = {
    'title': '',
    'description': '',
    'direction': '',
    'town': '',
    'lat': '',
    'lng': '',
    'price': '',
    'power': '',
    'power': '',
    'speed': [],
    'connection_type': [],
    'current_type': [],
  };

  var _speeds = [];
  var _selected_speeds = [];
  var _connection_types = [];
  var _selected_connection_types = [];
  var _current_types = [];
  var _selected_current_types = [];

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

  void nextPage() {
    setState(() {
      ++_page;
    });
  }

  void previousPage() {
    setState(() {
      --_page;
    });
  }

  void getBasicInfo(basic_info) {
    setState(() => {
          _data['title'] = basic_info['title'],
          _data['description'] = basic_info['description'],
          _data['price'] = basic_info['price'],
          _images = basic_info['images'],
        });
  }

  void getLocalization(localization) {
    setState(() => {
          _data['direction'] = localization['direction'],
          _data['town'] = localization['town'],
          _data['lat'] = localization['lat'],
          _data['lng'] = localization['lng'],
        });
  }

  void getSpeeds(speeds) {
    setState(() => {
          _data['speed'] = speeds,
        });
  }

  void getConnections(connections) {
    setState(() => {
          _data['connection_type'] = connections,
        });
  }

  void getCurrents(currents) {
    setState(() => {
          _data['current_type'] = currents['current_type'],
          _data['power'] = currents['power'],
        });
    send_data();
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case 0:
        {
          return BasicInfo(
            data: {
              'title': _data['title'],
              'description': _data['description'],
              'price': _data['price'],
              'images': _images
            },
            callback: getBasicInfo,
            nextPage: nextPage,
          );
        }
      case 1:
        {
          return LocalizationInfo(
            data: {
              'direction': _data['direction'],
              'town': _data['town'],
              'lat': _data['lat'],
              'lng': _data['lng'],
            },
            callback: getLocalization,
            nextPage: nextPage,
            prevPage: previousPage,
          );
        }
      case 2:
        {
          return SpeedInfo(data: {
            'speed': _data['speed'],
          }, callback: getSpeeds, nextPage: nextPage, prevPage: previousPage);
        }
      case 3:
        {
          return ConnectionInfo(
              data: {
                'connection_type': _data['connection_type'],
              },
              callback: getConnections,
              nextPage: nextPage,
              prevPage: previousPage);
        }
      case 4:
        {
          return CurrentInfo(data: {
            'current_type': _data['current_type'],
            'power': _data['power'],
          }, callback: getCurrents, prevPage: previousPage);
        }
      default:
        {
          return Center(
              child: Scaffold(
            body: SingleChildScrollView(child: Text("PAGE NOT EXISTENT")),
          ));
        }
    }
  }
}
