import 'package:flutter/material.dart';

import '../screens/chat/chat_view.dart';
import '../services/generalServices/WebSocketService.dart';

class ButtonSendMessageWidget extends StatefulWidget {
  TextEditingController controller;
  ScrollController scrollController;
  int to_user;
  ButtonSendMessageWidget({Key? key, required this.controller, required this.scrollController, required this.to_user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonSendMessageWidget();
}


class _ButtonSendMessageWidget extends State<ButtonSendMessageWidget>{
  final NotificationController notificationController =
  NotificationController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        // TODO: implement send message
        var messageObject = {
          'message': widget.controller.text,
          'to_user': widget.to_user,
        };

        print(widget.controller.text);

        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );

        widget.controller.clear();
        //TODO: añadir el mensaje a la lista de mensajes
        //notificationController.sendMessage(messageObject, );
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