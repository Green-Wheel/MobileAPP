import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chat.dart';
import 'package:greenwheel/serializers/users.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../services/backendServices/chat.dart';
import '../../services/generalServices/WebSocketService.dart';
import '../../widgets/message_widget.dart';

class ChatView extends StatefulWidget {
  String username;
  int? to_user;
  ChatView({Key? key, required this.username, required this.to_user}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: ChatView(username: "Michael Jordan", to_user: 1),
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
                      ChatService.deleteChat(widget.to_user!);
                      GoRouter.of(context).go('/chat');
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
  List<ChatRoomMessage> _messages = [
    /*ChatRoomMessage(
      content: "Hola",
      created_at: DateTime.now(),
      id: 1,
      sender: BasicUser(first_name: "Michael", last_name: "Jordan", username: "Michael Jordan"),
    ),
    ChatRoomMessage(
      content: "Hoa",
      created_at: DateTime.now(),
      id: 1,
      sender: BasicUser(first_name: "Kobe", last_name: "Bryant", username: "Kobe Bryant"),
    ),*/
  ];

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

  /*_updateMessages(List<ChatRoomMessage> messages) {
    setState(() {
      _messages.addAll(messages);
    });
  }*/

  Future<void> fetchData() async {
    try {
      final messages = await ChatService.getChatMessages(widget.to_user!);
      setState(() {
        _messages = messages;
        _isLastPage = _messages.length < _numberOfPostsPerRequest;
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
              if (index < 0) return Container();
              bool isMe = _messages[index].sender.id == LoginService().user_info?['id'];
              return MessageWidget( message: _messages[index].content, itsmine: isMe, created_at: DateFormat('dd-MM-yyyy hh:mm').format(_messages[index].created_at),);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_messages);
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
                        DeleteChat(widget!.to_user);
                      }
                  ),
                ],
              ),
            ),
            body: buildMessagesView(),
            bottomNavigationBar: inputTextMessage()//InputTextMessageWidget(controller: _controller, scrollController: _scrollController, to_user: widget.to_user, messages: _messages),
        )
      ],
    );
  }

  Widget inputTextMessage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TextFormField(
          controller: _controller,
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
            suffixIcon: buttonSendMessage(),
          ),
        ),
      ),
    );
  }

  Widget buttonSendMessage() {
    final NotificationController notificationController =
    NotificationController();
      return FloatingActionButton.small(
        onPressed: () {
          // TODO: implement send message
          print(_controller.text);

          var new_msg = ChatRoomMessage(
            id: widget.to_user!,
            sender: BasicUser(
                username: LoginService().user_info?['username'],
                first_name: LoginService().user_info?['first_name'],
                last_name: LoginService().user_info?['last_name'],
            ),
            content: _controller.text,
            created_at: DateTime.now(),
          );

          setState(() {
            _messages.add(new_msg);
          });

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );

          notificationController.SendMessage(_controller.text, widget.to_user!);
          _controller.clear();
        },
        elevation: 0,
        child: const Icon(
          Icons.send,
          color: Colors.green,
          size: 25,
        ),
        backgroundColor: Colors.white,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
      );
  }

}


