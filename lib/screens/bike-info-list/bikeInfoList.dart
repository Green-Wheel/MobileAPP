import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/backendServices/bikes.dart';
import '../../widgets/bike_card_info.dart';
import '../../widgets/bike_infinite_list.dart';

class BikeInfoList extends StatefulWidget {
  const BikeInfoList({Key? key}) : super(key: key);

  @override
  State<BikeInfoList> createState() => _BikeInfoListState();

}

class _BikeInfoListState extends State<BikeInfoList>{

  List markersList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bikes'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 125.0, left: 5.0),
            child: Icon(Icons.directions_bike_outlined),
          ),
        ],backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: BikeInfiniteList(),
    );
  }
}
