import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';
import 'package:intl/intl.dart';

import '../../widgets/message_widget.dart';

class ChatView extends StatefulWidget {
  //TODO: pasar el id del chat + username del otro usuario + mensajes
  List<String> messages = [];
  ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: ChatView(),
      ),
    ),
  );
}

class _ChatView extends State<ChatView> {
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
            const SizedBox(width: 20),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                  color: Colors.green,
                  Icons.person
              ),
            ),
            const SizedBox(width: 15),
            Username_Rating(username: "username", rating: "4.0", edit_button: false)
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //TODO: poner el chat (nuevo fichero) i fondo imagen
            SizedBox(height: 10),
            MessageWidget(message: "Hola", itsmine: true, read: true, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread:DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
            MessageWidget(message: "Hola", itsmine: false, read: true, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
            MessageWidget(message: "Adeu", itsmine: true, read: false, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),

          ],
        ),
      ),
      bottomNavigationBar: InputTextMessageWidget(),
    );
  }
}