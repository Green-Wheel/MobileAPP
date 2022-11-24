import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/forms/basic_info.dart';
import 'package:greenwheel/widgets/forms/bike_info.dart';
import 'package:greenwheel/widgets/forms/localization_info.dart';
import '../../serializers/maps.dart';
import '../../serializers/maps.dart';
import '../../services/backendServices/bikes.dart';

class BikeForm extends StatefulWidget {
  final data;

  const BikeForm({Key? key, this.data}) : super(key: key);

  @override
  State<BikeForm> createState() => _BikeFormState();
}

class _BikeFormState extends State<BikeForm> {
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
            'province': {'name': address.province},
          },
          _data['localization'] = {
            'latitude': localization.lat,
            'longitude': localization.lng,
          }
        });
  }

  void getBikeInfo(bike_info) {
    setState(() {
      _data['bike_type'] = bike_info['bike_type'];
      _data['power'] = bike_info['power'];
    });
    if (widget.data == null) {
      BikesService.newBike(_data, _images);
    } else {
      BikesService.updateBike(_data);
    }
    context.pop();
  }

  //widget functions
  @override
  void initState() {
    super.initState();
    _data = widget.data ??
        {
          'title': '',
          'description': '',
          'price': '',
          'direction': '',
          'localization': {
            'latitude': 0.0,
            'longitude': 0.0,
          },
          'town': {
            'name': '',
            'province': {
              'name': '',
            },
          },
          'bike_type': {
            'name': 'Electric',
          },
          'power': '0.0',
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
              'images': _images,
            },
            callback: getBasicInfo,
            nextPage: nextPage,
          );
        }
      case 1:
        {
          return LocalizationInfo(
            addres: _data['direction'],
            localization: LatLang(
                lat: _data['localization']['latitude'],
                lng: _data['localization']['longitude']),
            callback: getLocalization,
            nextPage: nextPage,
            prevPage: previousPage,
          );
        }
      case 2:
        {
          return BikeInfo(
              data: {
                'bike_type': _data['bike_type'],
                'power': _data['power'],
              },
              callback: getBikeInfo,
              prevPage: previousPage
          );
        }
    }

    return Container();
  }
}