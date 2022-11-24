import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/addCharger/charger_form.dart';

import '../../services/backendServices/private_chargers.dart';

class EditCharger extends StatefulWidget {
  final int id;

  const EditCharger({Key? key, required this.id}) : super(key: key);

  @override
  State<EditCharger> createState() => _EditChargerState();
}

class _EditChargerState extends State<EditCharger> {
  Map<String, dynamic> _chargerInfo = {};

  void getChargerInfo() async {
    var chargerI = await PrivateChargersService.getChargerInfo(widget.id);
    setState(() {
      _chargerInfo = chargerI;
    });
  }

  @override
  void initState() {
    super.initState();
    getChargerInfo();
  }

  @override
  Widget build(BuildContext context) {
    return _chargerInfo.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Edit Charger'),
            ),
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.height / 5,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              title: const Text('Add Charger'),
            ),
            body: Center(
              child: ChargerForm(
                data: _chargerInfo.isEmpty ? null : _chargerInfo,
              ),
            ),
          );
  }
}
