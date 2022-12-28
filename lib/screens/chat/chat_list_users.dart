import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';

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

class _ChatListUsers extends State<ChatListUsers> {
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
      body: SafeArea(
        child: Stack(
          children: [],
        )
      ),
    );
  }
}