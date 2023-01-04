import 'dart:core';

import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../ListUniqueSelectionModels.dart';

class ModelInfo extends StatefulWidget {
  int brandId;
  String modelName;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  ModelInfo(
      {Key? key,
        required this.brandId,
        required this.modelName,
        required this.callback,
        required this.nextPage,
        required this.prevPage})
      : super(key: key);

  @override
  State<ModelInfo> createState() => _ModelInfoState();
}

class _ModelInfoState extends State<ModelInfo> {
  List<CarModel> _models = [];

  void _getBrand() async {
    List<CarModel> modelList = await VehicleService.getVehicleBrand(widget.brandId);
    setState(() {
      _models = modelList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            ListUniqueSelectionModels(
              title: 'Choose a car model',
              items: _models,
              selectedItem: widget.modelName,
              onChanged: (value) {
                setState(() {
                  widget.modelName = value;
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
                      widget.callback(widget.modelName);
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
