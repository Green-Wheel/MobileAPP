import 'package:flutter/material.dart';

class ButtonSendMessageWidget extends StatefulWidget {
  const ButtonSendMessageWidget(
      {super.key});

  @override
  State<StatefulWidget> createState() => _ButtonSendMessageWidget();
}

main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(150.0),
        child: ButtonSendMessageWidget(),
      ),
    ),
  ));
}

class _ButtonSendMessageWidget extends State<ButtonSendMessageWidget>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        // TODO: implement send message
        print("hola");
      },
      child: const Icon(
        Icons.send,
        color: Colors.green,
        size: 25,
      ),
      backgroundColor: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
    );
  }
}