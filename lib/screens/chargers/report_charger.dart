import 'package:flutter/material.dart';
import 'package:greenwheel/screens/chargers/widgets/charger_basic_info.dart';
import 'package:greenwheel/screens/chargers/widgets/report_description_input.dart';
import 'package:greenwheel/screens/chargers/widgets/report_type_selector.dart';
import 'package:greenwheel/serializers/chargers.dart';
import 'package:go_router/go_router.dart';
import '../../services/backendServices/chargers.dart';

class ReportCharger extends StatefulWidget {
  final charger_id;

  const ReportCharger({Key? key, required this.charger_id}) : super(key: key);

  @override
  State<ReportCharger> createState() => _ReportChargerState();
}

class _ReportChargerState extends State<ReportCharger> {
  late DetailedCharherSerializer _bike;
  late List _reportTypes;
  var description = TextEditingController();

  List<String> _dummyTypes() {
    return ["Broken", "Not working", "Not charging", "Not available", "Other"];
  }

  void report() {
    print(description.text);
  }

  @override
  initState() {
    super.initState();
    _reportTypes = _dummyTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report charger"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            ChargerBasicInfo(
              charger_id: widget.charger_id,
            ),
            ReportTypeSelector(),
            const SizedBox(height: 10),
            ReportDescriptionInput(
              controller: description,
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                child: const Text("Report"),
                onPressed: report,
              )
            ])
          ]),
        ),
      ),
    );
  }
}
