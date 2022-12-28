import 'package:flutter/material.dart';
import 'package:greenwheel/screens/bike/widgets/bike_info.dart';
import 'package:greenwheel/screens/chargers/widgets/charger_basic_info.dart';
import 'package:greenwheel/screens/chargers/widgets/report_description_input.dart';
import 'package:greenwheel/screens/chargers/widgets/report_type_selector.dart';
import 'package:greenwheel/serializers/chargers.dart';
import 'package:go_router/go_router.dart';
import '../../serializers/bikes.dart';
import '../../services/backendServices/chargers.dart';

class ReportBike extends StatefulWidget {
  final bike_id;

  const ReportBike({Key? key, required this.bike_id}) : super(key: key);

  @override
  State<ReportBike> createState() => _ReportBikeState();
}

class _ReportBikeState extends State<ReportBike> {
  late DetailedBikeSerializer _bike;
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
        title: const Text("Report bike"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            BikeBasicInfo(
              bike_id: widget.bike_id,
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
                onPressed: report,
                child: const Text("Report"),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
