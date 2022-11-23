import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/addCharger/charger_form.dart';

class AddCharger extends StatefulWidget {
  const AddCharger({Key? key}) : super(key: key);

  @override
  State<AddCharger> createState() => _AddChargerState();
}

class _AddChargerState extends State<AddCharger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Charger'),
      ),
      body: const Center(
        child: ChargerForm(),
      ),
    );
  }
}
