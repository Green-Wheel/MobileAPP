import 'package:flutter/material.dart';

import '../screens/chat/chat_view.dart';

class ButtonSendMessageWidget extends StatefulWidget {
  TextEditingController controller;
  ScrollController scrollController;
  ButtonSendMessageWidget({Key? key, required this.controller, required this.scrollController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonSendMessageWidget();
}


class _ButtonSendMessageWidget extends State<ButtonSendMessageWidget>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        // TODO: implement send message
        //ChatView.SendMessage(widget.controller.text, 1, 2);
        print(widget.controller.text);
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        widget.controller.clear();
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