import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chat.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../services/backendServices/chat.dart';
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
                        GoRouter.of(context).go('/');
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
  late bool _isLastPage;
  late bool _error;
  late bool _loading;
  late int _pageNumber;
  final int _numberOfPostsPerRequest = 30;
  final int _nextPageTrigger = 3;
  List<ChatRoomMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = [];
    _error = false;
    _loading = true;
    _pageNumber = 1;
    _isLastPage = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final messages = await ChatService.getChatMessages(widget.id_chat!);
      setState(() {
        _messages = messages;
        _isLastPage = _messages.length > _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
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

  /*Widget errorDialog({required double size}){
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
  }*/

  Widget buildMessagesView() {
    if (_messages.isEmpty){
      if(_loading){
        return const Center(
            child:Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
            ));
      }/* else if(_error) {
        return errorDialog(size: 20);
      }*/
    }
    return Column(
      children: [
        Expanded(
          //TODO: change a listview.builder
          child:ListView.builder(
            controller: _scrollController,
            itemCount: _messages.length + (_isLastPage ? 0 : 1),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == 0) return Container();
              bool isMe = _messages[index].sender.id == LoginService().user_info!['id'];
              return MessageWidget( message: _messages[index].content, itsmine: isMe, created_at: _messages[index].created_at.toString(),);
            },
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
          "assets/images/background_chat.jpg",
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
            body: buildMessagesView(),
            //TODO: poner id to_user correspondiente
            bottomNavigationBar: InputTextMessageWidget(controller: _controller, scrollController: _scrollController, to_user: 1),
        )
      ],
    );
  }
  /*
               Column(
              children: [
                Expanded(
                  //TODO: change a listview.builder
                  child: ListView(
                      controller: _scrollController,
                      children:[
                        //TODO: poner el chat (nuevo fichero)
                        SizedBox(height: 10),
                        MessageWidget(message: "Hola", itsmine: true, created_at: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),),
                        MessageWidget(message: "Hola", itsmine: false, created_at: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),),
                      ]
                  ),
                ),
              ],
              ),
   */
}


