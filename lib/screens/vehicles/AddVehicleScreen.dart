import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/forms/vehicle_form.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: const Center(
        child: VehicleForm(),
      ),
    );
  }
}
