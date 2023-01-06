import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/chat.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';

import '../../widgets/card_chat_users.dart';

class ChatListUsers extends StatefulWidget {
  int unread = 0;
  ChatListUsers({Key? key, required this.unread}) : super(key: key);

  @override
  State<ChatListUsers> createState() => _ChatListUsers();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: ChatListUsers(unread: 0),
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

  int _number_new_messages = 0;
  List chats = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getChats();
  }

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


  Widget ListPoints(BuildContext context, List<ChatModel> list) {
    return Column(
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => CardChatUsersWidget(
                    username: list[index].username,
                    rate_user: list[index].rate_user,
                    last_message_received: list[index].last_message_received,
                    new_message: list[index].new_message,
                    last_message_time: list[index].last_message_time,
                    context: context,
                  ),
                )
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
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
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                      color: Colors.green,
                      Icons.chat
                  ),
                ),
                const SizedBox(width: 15),
                const Text("Chat", style: TextStyle(fontSize: 20, color: Colors.white),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                 Column(
                   children:[
                     Stack(
                         children: <Widget>[
                           Icon(
                               Icons.notifications,
                             size: 32,
                           ),
                           Positioned(  // draw a red marble
                             top: 0.0,
                             right: 0.0,
                             child: Stack (
                               children: [
                                 Icon(
                                   Icons.brightness_1, size: 17.0,
                                   color: Colors.redAccent,
                                 ),
                                 _number_new_messages < 10 ? Padding(
                                     padding: EdgeInsets.only(top: 3, left: 6.0),
                                     child: Text(_number_new_messages.toString(), style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),))
                                      : Padding(
                                     padding: EdgeInsets.only(top: 3, left: 3.0),
                                     child: Text(_number_new_messages.toString(), style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),))
                               ],
                             )
                             
                           ),
                         ]
                     ),
                     Text("New messages", style: TextStyle(fontSize: 10),),
                   ]
                 )
              ],
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                //Tab(icon: Icon(Icons.location_on_outlined), text: "My Markers", ),
                Tab(icon: Icon(Icons.supervised_user_circle), text: "Users"),
              ],
            ),
          ),
          //TODO: Poner listado de usuarios
          body: TabBarView(
            children: [
              //ListPoints(context, markers),
              ListPoints(context, users),
            ],
          ),
        ),
      ),
    );
  }
}
