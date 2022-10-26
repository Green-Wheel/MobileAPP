import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:0,left:20,right:20),
      child: Column(
        children : <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text("About Me",
                style: TextStyle(fontSize:24,fontWeight: FontWeight.bold)),
          ),
          Text("I like to move around with electric cars and i love to ride a cycle all around my town.",
            style: TextStyle(fontSize:16)
          ),
        ]
      )
    );
  }
}