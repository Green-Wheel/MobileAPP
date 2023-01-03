import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/reports.dart';

class ReportTypeSelector extends StatefulWidget {
  final Function submitSearch;

  const ReportTypeSelector({Key? key, required this.submitSearch})
      : super(key: key);

  @override
  State<ReportTypeSelector> createState() => _ReportTypeSelectorState();
}

class _ReportTypeSelectorState extends State<ReportTypeSelector> {
  List<String> _reportType = [];
  String _selectedReportType = "Broken";

  void _fetchReportTypes() async {
    var result = await ReportService.getReportTypes();
    setState(() {
      _reportType = result.isEmpty
          ? ["Broken", "Not working", "Not charging", "Not available", "Other"]
          : result;
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
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (text) {
            widget.submitSearch(text);
            setState(() {
              _selectedReportType = text as String;
            });
          },
        ),
      ),
    );
  }
}
