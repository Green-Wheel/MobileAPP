import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/chat/chat_view.dart';

class ButtonDeleteChargerWidget extends StatefulWidget {
  int? id_charger;
  ButtonDeleteChargerWidget({Key? key, required this.id_charger}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonDeleteChargerWidget();
}


main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 400),
          ButtonDeleteChargerWidget(id_charger: 1),
        ],
      ),
    ),
  ));
}

class _ButtonDeleteChargerWidget extends State<ButtonDeleteChargerWidget>{

  Future<void> DeleteCharger(int? id_charger) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Delete Marker of Charger"),
                SizedBox(width: 10),
                Icon(Icons.delete_forever_outlined),
              ],
            ),
            content: Text("Are you sure you want to delete this marker?"),
            actions: [
              Row(
                  children:[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                    TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/');
                        },
                        child: Text("Cancel")
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/charger/${widget.id_charger}');
                      },
                      child: Text("Delete", style: TextStyle(color: Colors.red),),
                    ),
                  ]
              )
            ],
          );
        }
    );
  }

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
          DeleteCharger(widget.id_charger);
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