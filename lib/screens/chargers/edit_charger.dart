import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/forms/charger_form.dart';

import '../../services/backendServices/private_chargers.dart';

class EditCharger extends StatefulWidget {
  final int id;

  const EditCharger({Key? key, required this.id}) : super(key: key);

  @override
  State<EditCharger> createState() => _EditChargerState();
}

class _EditChargerState extends State<EditCharger> {
  Map<String, dynamic> _chargerInfo = {};

  void _showAvisNoEsPodenCarregarCharger() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charger Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load charger'),
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

  void getChargerInfo() async {
    var chargerI = await PrivateChargersService.getChargerInfo(widget.id);
    if (chargerI == null) {
      _showAvisNoEsPodenCarregarCharger();
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit charger'),
      ),
      body: Center(
        child: _chargerInfo.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.height / 5,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : ChargerForm(
                data: _chargerInfo,
              ),
      ),
    );
  }
}
