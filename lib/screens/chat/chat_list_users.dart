import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';

import '../../widgets/card_chat_users.dart';

class ChatListUsers extends StatefulWidget {
  ChatListUsers({Key? key}) : super(key: key);

  @override
  State<ChatListUsers> createState() => _ChatListUsers();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: ChatListUsers(),
    ),
  ),
  );
}

class ChatModel {
  String username;
  double rate_user;
  String last_message_received;
  bool new_message;
  String last_message_time;
  ChatModel({required this.username, required this.rate_user, required this.last_message_received, required this.new_message, required this.last_message_time});
}

class _ChatListUsers extends State<ChatListUsers> {

  List<ChatModel> users = [
    ChatModel(
        username: "Michael Jordan",
        rate_user: 5.0,
        last_message_received: "see you on the court",
        new_message: true,
        last_message_time: "12:00",
    ),
    ChatModel(
        username: "Shaq O'Neil",
        rate_user: 3.0,
        last_message_received: "Chicken wings?",
        new_message: false,
        last_message_time: "11:00",
    ),
    ChatModel(
        username: "Kobe Bryant",
        rate_user: 4.5,
        last_message_received: "Can't stop me fella",
        new_message: false,
        last_message_time: "10:00",
    ),
    ChatModel(
        username: "Lebon James",
        rate_user: 2.5,
        last_message_received: "I can fly to high in the sky to dunk",
        new_message: true,
        last_message_time: "9:00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  //TODO: implementar ruta de chat
                  GoRouter.of(context).go('/');
                }
            ),
            const SizedBox(width: 65),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                  color: Colors.green,
                  Icons.person
              ),
            ),
            const SizedBox(width: 15),
            const Text("Clients", style: TextStyle(fontSize: 20, color: Colors.white),)
          ],
        ),
      ),
      //TODO: Poner listado de usuarios
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => CardChatUsersWidget(
                username: users[index].username,
                rate_user: users[index].rate_user,
                last_message_received: users[index].last_message_received,
                new_message: users[index].new_message,
                last_message_time: users[index].last_message_time,
                context: context,
                ),
              )
      )
    );
  }
}