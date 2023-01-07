import 'dart:core';

import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../ListUniqueSelectionModels.dart';

class ModelInfo extends StatefulWidget {
  int brandId;
  int modelId;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  ModelInfo(
      {Key? key,
        required this.brandId,
        required this.modelId,
        required this.callback,
        required this.nextPage,
        required this.prevPage})
      : super(key: key);

  @override
  State<ModelInfo> createState() => _ModelInfoState();
}

class _ModelInfoState extends State<ModelInfo> {
  List<CarModel> _models = [];
  late int selectedModel;
  late Future<List<CarModel>> _brandFuture;

  Future<List<CarModel>> _getBrand() async {
    List<CarModel> modelList = await VehicleService.getVehicleBrand(widget.brandId);
    if (modelList.isNotEmpty) {
      setState(() {
        _models = modelList;
        print('Models crida $_models');
        widget.modelId = _models[0].id;
        selectedModel = widget.modelId;
      });
      return modelList;
    } else {
      throw Exception('No models found for brand with id ${widget.brandId}');
    }
  }

  @override
  void initState() {
    super.initState();
    _brandFuture = _getBrand();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarModel>>(
      future: _brandFuture,
      builder: (BuildContext context, AsyncSnapshot<List<CarModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else { // snapshot.connectionState == ConnectionState.done
          _models = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                ListUniqueSelectionModels(
                  title: 'Choose a car model',
                  items: _models,
                  selectedItem: widget.modelId,
                  onChanged: (value) {
                    setState(() {
                      widget.modelId = value;
                      print('Model name updated: ${widget.modelId}');
                    });
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          widget.prevPage();
                        },
                        child: const Text('Previous'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          widget.callback(widget.modelId);
                          widget.nextPage();
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        }
      },
    );
  }
}
