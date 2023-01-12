import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/chat/chat_view.dart';

class ButtonDeleteBikeWidget extends StatefulWidget {
  int? id_bike;
  ButtonDeleteBikeWidget({Key? key, required this.id_bike}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonDeleteBikeWidget();
}


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
}

class _ButtonDeleteBikeWidget extends State<ButtonDeleteBikeWidget>{

  Future<void> DeleteBike(int? id_bike) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Delete Marker of Bike"),
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
                          //TODO: ruta pagina anterior
                          GoRouter.of(context).go('/');
                        },
                        child: Text("Cancel")
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                    TextButton(
                      onPressed: () {
                        //TODO: borrar chat ruta
                        GoRouter.of(context).go('/bikes/${widget.id_bike}');
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
          DeleteBike(widget.id_bike);
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