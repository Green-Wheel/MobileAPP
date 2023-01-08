import 'package:flutter/material.dart';

class ButtonSendMessageWidget extends StatefulWidget {
  const ButtonSendMessageWidget(
      {super.key});

  @override
  State<StatefulWidget> createState() => _ButtonSendMessageWidget();
}


class _ButtonSendMessageWidget extends State<ButtonSendMessageWidget>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        // TODO: implement send message
        print("hola");
      },
      elevation: 0,
      child: const Icon(
        Icons.send,
        color: Colors.green,
        size: 25,
      ),
      backgroundColor: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.green,
          width: 1,
        ),
      ),
    );
  }
}