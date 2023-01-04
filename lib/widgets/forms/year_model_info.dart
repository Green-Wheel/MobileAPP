import 'dart:core';

import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../ListUniqueSelectionYearModels.dart';

class YearModelInfo extends StatefulWidget {
  var data;
  int brandId;
  String modelName;
  final Function callback;
  final Function prevPage;

  YearModelInfo(
      {Key? key,
        required this.data,
        required this.brandId,
        required this.modelName,
        required this.callback,
        required this.prevPage})
      : super(key: key);

  @override
  State<YearModelInfo> createState() => _YearModelInfoState();
}

class _YearModelInfoState extends State<YearModelInfo> {
  List<CarBrandYear> _yearModels = [];

  void _getBrands() async {
    List<CarBrandYear> yearModelList = await VehicleService.getVehicleBrandYear(widget.brandId, widget.modelName);
    setState(() {
      _yearModels = yearModelList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            ListUniqueSelectionYearModels(
              title: 'Choose a car year model for ${widget.modelName}',
              items: _yearModels,
              selectedItem: widget.data['model'],
              onChanged: (value) {
                setState(() {
                  widget.data['model'] = value;
                });
              },
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
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      widget.callback(widget.brandId);
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
