import 'package:flutter/material.dart';

class ReportDescriptionInput extends StatefulWidget {
  TextEditingController controller;

  ReportDescriptionInput({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ReportDescriptionInput> createState() => _ReportDescriptionInputState();
}

class _ReportDescriptionInputState extends State<ReportDescriptionInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Descrive the issue textAligneport",
                    style: TextStyle(fontSize: 15)),
                TextFormField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
