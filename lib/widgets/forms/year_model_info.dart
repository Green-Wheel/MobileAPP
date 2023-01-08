import 'dart:core';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../ListUniqueSelectionYearModels.dart';

class YearModelInfo extends StatefulWidget {
  var data;
  int brandId;
  int modelId;
  final Function callback;
  final Function prevPage;

  YearModelInfo(
      {Key? key,
        required this.data,
        required this.brandId,
        required this.modelId,
        required this.callback,
        required this.prevPage})
      : super(key: key);

  @override
  State<YearModelInfo> createState() => _YearModelInfoState();
}

class _YearModelInfoState extends State<YearModelInfo> {
  List<CarBrandYear> _yearModels = [];
  late int selectedYearModel;
  late Future<List<CarBrandYear>> _yearModelFuture;

  Future<List<CarBrandYear>> _getYearModels() async {
    List<CarBrandYear> yearModelList = await VehicleService.getVehicleBrandYear(widget.brandId, widget.modelId);
    if (yearModelList.isNotEmpty) {
      setState(() {
        _yearModels = yearModelList;
        print('YearModels crida $_yearModels');
        widget.data['model'] = _yearModels[0].id;
        selectedYearModel = widget.data['model'];
      });
      return yearModelList;
    } else {
      throw Exception('No year models found for this year model');
    }
  }

  @override
  void initState() {
    super.initState();
    _yearModelFuture = _getYearModels();
  }

  @override
  Widget build(BuildContext context) {
    print('hey ${widget.data['model']}');
    print(_yearModels);
    return FutureBuilder<List<CarBrandYear>>(
        future: _yearModelFuture,
        builder: (BuildContext context, AsyncSnapshot<List<CarBrandYear>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else { // snapshot.connectionState == ConnectionState.done
        _yearModels = snapshot.data!;
        return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                ListUniqueSelectionYearModels(
                  title: 'Choose a car year model',
                  items: _yearModels,
                  selectedItem: widget.data['model'],
                  onChanged: (value) {
                    setState(() {
                      widget.data['model'] = value;
                      print('Model year updated: ${widget.data['model']}');
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
                          widget.callback(widget.data['model']);
                          GoRouter.of(context).go('/');
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ]),
            ));
      }
    });
  }
}
