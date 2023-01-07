import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/button_send_message.dart';

import '../serializers/chat.dart';

class InputTextMessageWidget extends StatefulWidget {
  TextEditingController controller;
  ScrollController scrollController;
  int? to_user;
  List<ChatRoomMessage> messages;
  InputTextMessageWidget({Key? key, required this.controller, required this.scrollController, required this.to_user, required this.messages}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextMessageWidget();
}


class _InputTextMessageWidget extends State<InputTextMessageWidget> {
  @override
  Widget build(BuildContext context) {
    //TODO: mirar tema controlador
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TextFormField(
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type a message',
            prefix: const SizedBox(
              width: 10,
            ),
            suffixIcon: ButtonSendMessageWidget(controller: widget.controller,
                scrollController: widget.scrollController, to_user: widget.to_user, messages: widget.messages),
            ),
          ),
        ),
      );
  }
}
