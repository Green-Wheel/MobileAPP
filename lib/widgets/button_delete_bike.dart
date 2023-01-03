import 'package:flutter/material.dart';

import '../screens/chat/chat_view.dart';

class ButtonDeleteBikeWidget extends StatefulWidget {
  int? id_bike;
  ButtonDeleteBikeWidget({Key? key, required this.id_bike}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonDeleteBikeWidget();
}

/*
main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 400),
          ButtonDeleteBikeWidget(id_bike: 1),
        ],
      ),
    ),
  ));
}*/

class _ButtonDeleteBikeWidget extends State<ButtonDeleteBikeWidget>{
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 33,
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<
                Color>(Colors.red[100]!),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0),
                    side: const BorderSide(
                        color: Colors.redAccent)
                )
            )
        ),
        onPressed: () {

        },
        child: Row(
          children: const [
            Icon(
              Icons.delete,
              size: 18,
              color: Colors.redAccent,
            ),
            Text('Delete',
              style: TextStyle(
                fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}