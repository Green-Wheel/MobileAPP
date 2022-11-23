import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/forms/bike_form.dart';

class AddBike extends StatefulWidget {
  const AddBike({Key? key}) : super(key: key);

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bike'),
      ),
      body: const Center(
        child: BikeForm(),
      ),
    );
  }
}
