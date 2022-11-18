import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BikeInfo extends StatefulWidget {
  const BikeInfo({Key? key}) : super(key: key);

  @override
  State<BikeInfo> createState() => _BikeInfoState();
}

class _BikeInfoState extends State<BikeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Bike Info',
            ),
          ],
        ),
      ),
    );
  }
}