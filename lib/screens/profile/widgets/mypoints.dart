import 'package:flutter/material.dart';

class MyPoints extends StatelessWidget {
  const MyPoints( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:0,left:20,right:20),
      child: Row(
        children: <Widget> [
          Text("My Points",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}