import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  //TODO: servidor de socket
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  void connect() {
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  void SendMessage(String message, int sourceId, int destinationId) {
    socket.emit('message', [message, sourceId, destinationId]);
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/no_image.png",
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
            body:Column(
              children: [
                Expanded(
                    child: ListView(
                      controller: _scrollController,
                      children:[
                          //TODO: poner el chat (nuevo fichero)
                          SizedBox(height: 10),
                          MessageWidget(message: "Hola", itsmine: true, read: true, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread:DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
                          MessageWidget(message: "Hola", itsmine: false, read: true, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
                          MessageWidget(message: "Adeu", itsmine: true, read: false, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
                          MessageWidget(message: "HUguvhkgkkcgckgkctgcjcfgcfcfxfcjfjcgcghhhhhhhhhhcghcghcghcghcghtytyt", itsmine: true, read: false, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
                          MessageWidget(message: "HUguvhkgkkcgckgkctgcjcfgcfcfxfcjfjcgcghhhhhhhhhhcghcghcghcghcghtytyt", itsmine: false, read: false, datesend: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), dateread: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
                      ]
                    ),
                ),
              ],
            ),
            bottomNavigationBar: InputTextMessageWidget(controller: _controller, scrollController: _scrollController),
        )
      ],
    );
  }
}