import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../widgets/message_widget.dart';

class ChatView extends StatefulWidget {
  String username;
  int? id_chat;
  ChatView({Key? key, required this.username, required this.id_chat}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: ChatView(username: "Michael Jordan", id_chat: 1),
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

  Future<void> DeleteChat(int? id_chat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Delete chat"),
                SizedBox(width: 10),
                Icon(Icons.delete_forever_outlined),
              ],
            ),
            content: Text("Are you sure you want to delete this chat?"),
            actions: [
              Row(
                children:[
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                  TextButton(
                      onPressed: () {
                        //TODO: ruta pagina anterior
                      },
                      child: Text("Cancel")
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                  TextButton(
                    onPressed: () {
                      //TODO: borrar chat ruta
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.red),),
                  ),
                ]
              )
            ],
          );
        }
    );
  }

  late bool _error;
  late bool _loading;
  late int _pageNumber;
  final int _numberOfPostsPerRequest = 30;
  final int _nextPageTrigger = 3;
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = [];
    _error = false;
    _loading = true;
    _pageNumber = _messages.length - 1;
    connect();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
       // _getBikesList(_pageNumber);
        //_isFirstPage = _markersListAll.length < _numberOfPostsPerRequest;
        _loading = false;
        //_pageNumber = _pageNumber - 1;
        //_markersListAll.addAll(_markersList);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}){
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed:  ()  {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.blueAccent),)),
        ],
      ),
    );
  }

  Widget buildMessagesView() {
    if (_messages.isEmpty){
      if(_loading){
        return const Center(
            child:Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
            ));
      } else if(_error) {
        return errorDialog(size: 20);
      }
    }
    return Column(
      children: [
        Expanded(
          //TODO: change a listview.builder
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
    );
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                        color: Colors.green,
                        Icons.person
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Text(widget.username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 30,
                      onPressed: () {
                        DeleteChat(widget!.id_chat);
                      }
                  ),
                ],
              ),
            ),
            body:Column(
              children: [
                Expanded(
                  //TODO: change a listview.builder
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


