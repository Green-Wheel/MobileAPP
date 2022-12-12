import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chargers.dart';
import 'package:greenwheel/widgets/card_info.dart';

import '../../services/backendServices/chargers.dart';
import '../../widgets/infinite_list.dart';
import '../home/widgets/list_charger_filters_map.dart';

class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}

class _ChargeInfoListState extends State<ChargeInfoList>{
  List markersList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargers'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 125.0, left: 5.0),
            child: Icon(Icons.location_on_outlined),
          ),
        ],
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: const InfiniteList(),
    );
  }
}

