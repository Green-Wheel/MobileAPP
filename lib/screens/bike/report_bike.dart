import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:greenwheel/screens/bike/widgets/bike_basic_info.dart';
import 'package:greenwheel/services/backendServices/report_service.dart';
import 'package:greenwheel/widgets/report_type_selector.dart';

import '../../widgets/report_description_input.dart';

class ReportBike extends StatefulWidget {
  final bike_id;

  const ReportBike({Key? key, required this.bike_id}) : super(key: key);

  @override
  State<ReportBike> createState() => _ReportBikeState();
}

class _ReportBikeState extends State<ReportBike> {
  var description = TextEditingController();
  var reason = 1;

  void setReason(id) {
    reason = id;
  }

  void report() {
    ReportService.reportPublication(widget.bike_id, description.text, reason).then((value) => GoRouter.of(context).pop());
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
            /*BikeBasicInfo(
              bike_id: widget.bike_id,
            ),*/
            ReportTypeSelector(
              submitSearch: setReason,
            ),
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
