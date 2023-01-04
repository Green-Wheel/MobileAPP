import 'dart:core';

import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../ListUniqueSelectionBrands.dart';

class BrandInfo extends StatefulWidget {
  int brandId;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  BrandInfo(
      {Key? key,
        required this.brandId,
        required this.callback,
        required this.nextPage,
        required this.prevPage})
      : super(key: key);

  @override
  State<BrandInfo> createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  List<CarBrand> _brands = [];

  void _getBrands() async {
    List<CarBrand> brandList = await VehicleService.getVehicleBrands();
    setState(() {
      _brands = brandList;
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
            ListUniqueSelectionBrands(
              title: 'Choose a car brand',
              items: _brands,
              selectedItemId: widget.brandId,
              onChanged: (value) {
                setState(() {
                  widget.brandId = value;
                });
              },
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
                      widget.callback(widget.brandId);
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
