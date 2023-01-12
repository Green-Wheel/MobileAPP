import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/profile/widgets/comment_basic_info.dart';
import 'package:greenwheel/services/backendServices/report_service.dart';
import 'package:greenwheel/widgets/report_type_selector.dart';

import '../../widgets/report_description_input.dart';

class ReportComment extends StatefulWidget {
  final comment_id;

  const ReportComment({Key? key, required this.comment_id}) : super(key: key);

  @override
  State<ReportComment> createState() => _ReportCommentState();
}

class _ReportCommentState extends State<ReportComment> {
  var description = TextEditingController();
  var reason = 1;

  void setReason(id) {
    reason = id;
  }

  void report() {
    ReportService.reportRating(widget.comment_id, description.text, reason).then((value) => GoRouter.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report rating"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            CommentBasicInfo(
              comment_id: widget.comment_id,
            ),
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
