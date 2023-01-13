import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/reports.dart';

import '../services/backendServices/report_service.dart';

class ReportTypeSelector extends StatefulWidget {
  final Function submitSearch;

  const ReportTypeSelector({Key? key, required this.submitSearch})
      : super(key: key);

  @override
  State<ReportTypeSelector> createState() => _ReportTypeSelectorState();
}

class _ReportTypeSelectorState extends State<ReportTypeSelector> {
  List<ReportReasonSerializer> _reportType = [];
  int _selectedReportType = 1;

  void _fetchReportTypes() async {
    var result = await ReportService.getReportTypes();
    if(result.isEmpty) result = [ReportReasonSerializer(name: 'Broken', id: 1), ReportReasonSerializer(name: 'Fake', id: 2), ReportReasonSerializer(name: 'Other', id: 3)];
    setState(() {
      _reportType = result;
      _selectedReportType = _reportType[0].id != null ? _reportType[0].id! : 1;
    });
    }

  @override
  void initState() {
    super.initState();
    _fetchReportTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.08,
        child: DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          value: _selectedReportType,
          dropdownColor: Colors.white,
          items: _reportType.map((item) {
            return DropdownMenuItem(
              value: item.id,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (text) {
            widget.submitSearch(text);
            setState(() {
              _selectedReportType = text as int;
            });
          },
        ),
      ),
    );
  }
}
