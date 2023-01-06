import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/chat/chat_list_users.dart';

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
    List chatsrequest = await ChatService.getChats();
    if (chatsrequest.isEmpty && !loading){
      print("No chats");
      _showAvisNoEsPotCarregarChat();
    }
    else if (loading){
      print("Loading chats");
    }
    print("Chats loaded");
    print(chats);
    setState(() {
      loading = false;
      chats = chatsrequest;
    });
  }

  int _getChatId(){
    for (var chat in chats){
      if (chat.to_user == widget.to_user){
        return chat.id;
      }
    }
    return -1;
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
          //TODO: Ruta a chat
          int chat_id = _getChatId();
          if (chat_id == -1){
            _showAvisNoEsPotCarregarChat();
            //Crear chat
          }
          else{
            GoRouter.of(context).go('/chats/$chat_id');
          }
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