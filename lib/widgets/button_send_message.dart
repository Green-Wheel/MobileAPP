import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/chat.dart';
import 'package:greenwheel/serializers/users.dart';

import '../screens/chat/chat_view.dart';
import '../services/generalServices/LoginService.dart';
import '../services/generalServices/WebSocketService.dart';

class ButtonSendMessageWidget extends StatefulWidget {
  TextEditingController controller;
  ScrollController scrollController;
  int? to_user;
  //ValueChanged<List<ChatRoomMessage>> messages;
  List<ChatRoomMessage> messages;
  ButtonSendMessageWidget({Key? key, required this.controller, required this.scrollController, required this.to_user, required this.messages}) : super(key: key);

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
        print(widget.controller.text);

        var new_msg = ChatRoomMessage(
          id: 1,//widget.to_user!,
          sender: BasicUser(
            username: 'user',//LoginService().user_info?['username'],
            first_name: 'anomi',//LoginService().user_info?['first_name'],
            last_name: 'romero'//LoginService().user_info?['last_name'],
          ),
          content: "hola", //widget.controller.text,
          created_at: DateTime.now(),
        );

        widget.messages.add(new_msg);
        print(widget.messages);

        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );

        notificationController.SendMessage(widget.controller.text, widget.to_user!);
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