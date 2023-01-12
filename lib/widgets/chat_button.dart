import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/chat/chat_list_users.dart';

import '../serializers/chat.dart';
import '../services/backendServices/chat.dart';

class ChatButtonWidget extends StatefulWidget {
  int? to_user;
  ChatButtonWidget({Key? key, required this.to_user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatButtonWidget();
}

class _ChatButtonWidget extends State<ChatButtonWidget>{

  bool loading = true;
  List chats = [];
  List<ChatRoom> userschats = [];
  //get de chats y buscar uno que tenga el to_user = widget.to_user, sino
  void _showAvisNoEsPotCarregarChat() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chat Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load chat info'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getChats() async {
    ChatRoom? chatsrequest = await ChatService.getChatsId(widget.to_user);
    if (chatsrequest?.id == null && !loading){
      print("No chats");
      _showAvisNoEsPotCarregarChat();
    }
    else if (loading){
      print("Loading chats");
    }
    print(chatsrequest?.id);
    print("Chats loaded");
    print(chats);
    setState(() {
      loading = false;
      userschats.add(chatsrequest!);
    });
  }

  @override
  void initState() {
    super.initState();
    _getChats();
  }

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
        onPressed: () {
          print("usuario ${widget.to_user}");
          //TODO: Ruta a chat
          GoRouter.of(context).push('/chats/${widget.to_user}');

        },
        child: Row(
          children: const [
            Icon(
              Icons.chat,
              size: 18,
              color: Colors.blueAccent,
            ),
            SizedBox(width: 5),
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