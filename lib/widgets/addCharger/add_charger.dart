import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/widgets/addCharger/connection_info.dart';
import 'package:greenwheel/widgets/addCharger/current_info.dart';
import 'package:greenwheel/widgets/addCharger/localization_info.dart';
import 'package:greenwheel/widgets/addCharger/speed_%20info.dart';
import 'package:greenwheel/widgets/addCharger/basic_info.dart';
import '../../serializers/maps.dart';

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

  int _page = 0;

  List<File> _images = [];

  final _data = {
    'title': '',
    'description': '',
    'direction': '',
    'lat': 0.0,
    'lng': 0.0,
    'town': {},
    'connection_type': [{}],
    'current_type': [{}],
    'speed': [{}],
    'power': int,
    'avg_rating': double,
    'charge_type': '',
    'price': '',
  };

  void send_data() async {
    try {
      var response = await BackendService.post('chargers/private/', _data);
      if (response.statusCode == 200) {
        print('Charger added');
      } else {
        throw Exception('Failed to add charger');
      }
    } catch (e) {
      print(e);
    }
  }

/*
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
*/

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

  void getLocalization(LatLang localization, Address address) {
    setState(() => {
          _data['direction'] =
              '${address.street}, ${address.streetNumber}, ${address.postalCode}',
          _data['town'] = {
            'name': address.city,
            'province': address.province,
          },
          _data['lat'] = localization.lat,
          _data['lng'] = localization.lng
        });
  }

  void getSpeeds(speeds) {
    setState(() => {
          _data['speed'] = speeds.map((s) => {'name': s}).toList(),
        });
  }

  void getConnections(connections) {
    setState(() => {
          _data['connection_type'] =
              connections.map((c) => {'name': c}).toList(),
        });
  }

  void getCurrents(currents) {
    setState(() => {
          _data['current_type'] =
              currents['current_type'].map((c) => {'name': c}).toList(),
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
            addres: _data['direction'],
            localization:
                LatLang.fromJson({'lat': _data['lat'], 'lng': _data['lng']}),
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
