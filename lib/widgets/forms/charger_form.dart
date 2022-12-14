import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/forms/connection_info.dart';
import 'package:greenwheel/widgets/forms/current_info.dart';
import 'package:greenwheel/widgets/forms/localization_info.dart';
import 'package:greenwheel/widgets/forms/speed_%20info.dart';
import 'package:greenwheel/widgets/forms/basic_info.dart';
import '../../serializers/maps.dart';
import '../../services/backendServices/private_chargers.dart';

class ChargerForm extends StatefulWidget {
  final data;

  const ChargerForm({Key? key, this.data}) : super(key: key);

  @override
  State<ChargerForm> createState() => _ChargerFormState();
}

class _ChargerFormState extends State<ChargerForm> {
  //variables
  int _page = 0;
  List<File> _images = [];
  late final Map<String, dynamic> _data;

  //functions
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
          _data['latitude'] = localization.lat,
          _data['longitude'] = localization.lng,
        });
  }

  void getSpeeds(speeds) {
    setState(() => {
          _data['speed'] = speeds["speed"],
        });
  }

  void getConnections(connections) {
    setState(() => {
          _data['connection_type'] = connections['connection_type'],
        });
  }

  Future<void> getCurrents(currents) async {
    setState(() => {
          _data['current_type'] = currents['current_type'],
          _data['power'] = currents['power'],
        });
    if (widget.data != null) {
      bool bPrivUpdateCharger = await PrivateChargersService.updateCharger(_data);
      if (!bPrivUpdateCharger) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return const AlertDialog(
              title: Text('Charger Updated Successfully'),
            );
          }
        );
      }
    } else {
      bool bPrivNewCharger = await PrivateChargersService.newCharger(_data, _images);
      if (!bPrivNewCharger) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return const AlertDialog(
              title: Text('Charger Created Successfully'),
            );
          }
        );
      }
    }
    GoRouter.of(context).push('/');
  }

  //widget functions
  @override
  void initState() {
    super.initState();
    _data = widget.data ??
        {
          'title': '',
          'description': '',
          'direction': '',
          'latitude': 0,
          'longitude': 0,
          'town': {},
          'connection_type': [],
          'current_type': [],
          'speed': [],
          'power': "",
          'avg_rating': 0.0,
          'charge_type': '',
          'price': '',
        };
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
            localization: LatLang.fromJson(
                {'lat': _data['latitude'], 'lng': _data['longitude']}),
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
          return const Center(
              child: Scaffold(
            body: SingleChildScrollView(child: Text("PAGE NOT EXISTENT")),
          ));
        }
    }
  }
}
