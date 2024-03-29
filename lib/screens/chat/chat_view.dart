import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chat.dart';
import 'package:greenwheel/serializers/users.dart';
import 'package:greenwheel/services/backendServices/user_service.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../services/backendServices/chat.dart';
import '../../services/generalServices/WebSocketService.dart';
import '../../widgets/message_widget.dart';

class ChatView extends StatefulWidget {
  String? username;
  int to_user;

  ChatView({Key? key, required this.to_user, this.username}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  IOWebSocketChannel? channel;
  int userId = LoginService().user_info?['id'];

  late bool _error;
  late bool _loading;
  late int _pageNumber;
  BasicUser? _receiver_user = null;
  List<ChatRoomMessage> _messages = [];
  List<ChatRoomMessage> _allmessages = [];

  @override
  void initState() {
    super.initState();
    _messages = [];
    _error = false;
    _loading = true;
    _pageNumber = 1;
    _getReceiverUser();
    fetchData();
    channelconnect();
  }

  channelconnect() {
    try{
      channel = IOWebSocketChannel.connect(Uri.parse('ws://3.250.219.80/ws/$userId/chats/messages/')); //channel IP : Port
      late var channelStream = channel?.stream.asBroadcastStream();
      channelStream?.listen((message) {
        Map msg = json.decode(message);
          if (msg["type"] == "send.message" && msg["sender"]["id"] != userId) {
            if (msg["sender"]["id"] == widget.to_user) {
              listenMessage(msg);
              ChatService.putUnreadMessage(msg["room_id"]);
            } else {
              // @TODO ENVIAR NOTIFICACIO
            }
          }
        },
        onDone: () {
          channelconnect();
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (e) {
      print("Error connecting $e");
    }
  }

  Future<void> _getReceiverUser() async {
    try {
      ChatService.getChatsId(widget.to_user).then((value) {
        if (value != null) {
          setState(() {
            _receiver_user = value.to_user;
          });
        } else {
          if (widget != null && widget.to_user != null) {
            UserService.getUser(widget.to_user).then((value) {
              if (value != null) {
                setState(() {
                  _receiver_user = BasicUser(
                      username: value.username,
                      first_name: value.first_name,
                      last_name: value.last_name,
                      profile_picture: value.profile_picture);
                });
              }
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    try {
      final messages = await ChatService.getChatMessagesPage(widget.to_user!, _pageNumber);
      setState(() {
        List<ChatRoomMessage> msg = messages.reversed.toList();
        msg.addAll(_messages);
        _messages = msg;
        _loading = false;
        _pageNumber = _pageNumber + 1;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.84,
              child:ListView.builder(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              itemCount: _messages.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                int itemCount = _messages.length;
                int reversedIndex = itemCount - 1 - index;

                if (reversedIndex == 3){
                  fetchData();
                }

                if (index < 0) return Container();
                bool isMe = _messages[reversedIndex].sender.username == LoginService().user_info?['username'];
                return MessageWidget( message: _messages[reversedIndex].content, itsmine: isMe, created_at: DateFormat('dd-MM-yyyy HH:mm').format(_messages[reversedIndex].created_at),);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //fetchData();
    return Stack(
      children: [
        Image.asset(
          "assets/images/background_chat.jpg",
          //_receiver_user?.profile_picture != null ? _receiver_user!.profile_picture! : "assets/images/background_chat.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
              title: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        GoRouter.of(context).go("/chats/");
                    }
                  ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(color: Colors.green, Icons.person),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                Text(_receiver_user != null ? _receiver_user!.username : "",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                /*IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 30,
                      onPressed: () {
                        DeleteChat(widget!.to_user);
                      }
                  ),*/
              ],
              ),
            ),
            body: !_loading ? SingleChildScrollView(
              //height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
                    child: buildMessagesView(),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                      child: inputTextMessage(),
                  )
                ]

              ),
            ): Center(
                child:Padding(
                  padding: EdgeInsets.all(25),
                  child: CircularProgressIndicator(),
                )),
        )
      ],
    );
  }

  Widget inputTextMessage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width ,
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
            hintStyle: TextStyle(color: Colors.grey),
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

  void listenMessage(Map msg){
    setState(() {
      _messages.add(ChatRoomMessage(
        content: msg['content'],
        created_at: DateTime.now(),
        id: msg['id'],
        sender: BasicUser(
            first_name: msg['sender']['first_name'],
            last_name: msg['sender']['last_name'],
            username: msg['sender']['username']),
      ));
    });
  }

  void SendMessage (String message, int to_user){
    try{
      channel?.sink.add(jsonEncode({
        "message": message,
        "to_user": to_user,
      }));
    } on Exception catch(e){
      print(e);
    }
  }

  Widget buttonSendMessage() {
      return FloatingActionButton.small(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            var new_msg = ChatRoomMessage(
              id: widget.to_user!,
              sender: BasicUser(
                username: LoginService().user_info?['username'] ?? '',
                first_name: LoginService().user_info?['first_name'] ?? '',
                last_name: LoginService().user_info?['last_name'] ?? '',
              ),
              content: _controller.text,
              created_at: DateTime.now(),
            );

            setState(() {
              _messages.add(new_msg);
            });

            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );

            SendMessage(_controller.text, widget.to_user!);
            _controller.clear();
          }
        },
        elevation: 0,
        child: const Icon(
          Icons.send,
          color: Colors.green,
          size: 25,
        ),
        backgroundColor: Colors.white,
      );
  }

}

/*Future<void> DeleteChat(int? id_chat) {
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
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                  TextButton(
                    onPressed: () {
                      ChatService.deleteChat(widget.to_user!);
                      GoRouter.of(context).go('/chats');
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.red),),
                  ),
                ]
              )
            ],
          );
        }
    );
  }*/


