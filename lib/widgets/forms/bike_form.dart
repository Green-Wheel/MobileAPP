import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/forms/basic_info.dart';
import 'package:greenwheel/widgets/forms/localization_info.dart';
import '../../serializers/maps.dart';
import '../../serializers/maps.dart';

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
            'province': address.province,
          },
          _data['latitude'] = localization.lat,
          _data['longitude'] = localization.lng,
        });
  }

  //widget functions
  @override
  void initState() {
    super.initState();
    _data = widget.data ??
        {
          'title': '',
          'description': '',
          'price': 0,
          'direction': '',
          'town': {
            'name': '',
            'province': '',
          },
          'latitude': 0,
          'longitude': 0,
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
            localization: LatLang.fromJson(
                {'lat': _data['latitude'], 'lng': _data['longitude']}),
            callback: getLocalization,
            nextPage: nextPage,
            prevPage: previousPage,
          );
        }
    }

    return Container();
  }
}
