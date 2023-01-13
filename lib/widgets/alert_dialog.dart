import 'package:flutter/material.dart';

Future<String?> showAlert(BuildContext context,String state, String error){
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:   Text(state),
      content: Text(error),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}