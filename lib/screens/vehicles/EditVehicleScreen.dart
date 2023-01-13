import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/vehicles.dart';

import '../../widgets/forms/vehicle_form.dart';

class EditVehicle extends StatefulWidget {
  final int id;

  const EditVehicle({Key? key, required this.id}) : super(key: key);

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  Map<String, dynamic> _vehicleInfo = {};

  void _showAvisNoEsPotCarregarVehicle() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('vehicle Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load vehicle'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getVehicleInfo() async {
    print('entra a getVehicleInfo');
    //var vehicleI = await VehicleService.getVehicle(widget.id);
    var vehicleI = await VehicleService.getVehicleSerialized(widget.id);
    Map<String, dynamic>? vehicleInfo = vehicleI?.toJson();
    print('vehicle $vehicleInfo');
    if (vehicleI == null) {
      _showAvisNoEsPotCarregarVehicle();
    }
    setState(() {
      _vehicleInfo = vehicleInfo!;
    });
  }

  @override
  void initState() {
    super.initState();
    getVehicleInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit vehicle'),
      ),
      body: Center(
        child: _vehicleInfo.isEmpty
            ? SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.height / 5,
          child: const CircularProgressIndicator(
            color: Colors.green,
            backgroundColor: Colors.white,
          ),
        )
            : VehicleForm(
          data: _vehicleInfo,
          id: widget.id,
        ),
      ),
    );
  }
}
