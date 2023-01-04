import 'package:flutter/material.dart';

class VehicleBasicInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;

  VehicleBasicInfo(
      {Key? key,
        required this.data,
        required this.callback,
        required this.nextPage})
      : super(key: key);

  @override
  State<VehicleBasicInfo> createState() => _VehicleBasicInfoState();
}

class _VehicleBasicInfoState extends State<VehicleBasicInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Name"),
                TextFormField(
                  initialValue: widget.data['alias'],
                  onSaved: (value) {
                    widget.data['alias'] = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter vehicle name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Car License"),
                TextFormField(
                  initialValue: widget.data['car_license'],
                  onSaved: (value) {
                    widget.data['car_license'] = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your car license';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Charge Capacity"),
                TextFormField(
                  initialValue: widget.data['charge_capacity'].toString() != '0.0' ? widget.data['charge_capacity'].toString() : '',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    widget.data['charge_capacity'] = double.parse(value!);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter charge capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.callback(widget.data);
                        widget.nextPage();
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
