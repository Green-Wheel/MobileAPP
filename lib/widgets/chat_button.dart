import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatButtonWidget extends StatefulWidget {

  const ChatButtonWidget(
      {super.key});

  @override
  State<StatefulWidget> createState() => _ChatButtonWidget();
}

class _ChatButtonWidget extends State<ChatButtonWidget>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<
                Color>(Colors.lightBlue[50]!),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0),
                    side: const BorderSide(
                        color: Colors.blueAccent)
                )
            )
        ),
        onPressed: () {},
        child: Row(
          children: const [
            Icon(
              Icons.chat,
              size: 20,
              color: Colors.blueAccent,
            ),
            Text('Chat ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}