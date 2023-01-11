import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/users.dart';
import 'package:greenwheel/services/backendServices/chat.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';


import '../../serializers/chat.dart';
import '../../widgets/card_chat_users.dart';

class ChatListUsers extends StatefulWidget {
  ChatListUsers({Key? key,}) : super(key: key);

  @override
  State<ChatListUsers> createState() => _ChatListUsers();
}

class _ChatListUsers extends State<ChatListUsers> {

  int _number_new_messages = 0;
  List<ChatRoom> chats = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getChats();
  }


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
    //ChatRoom? chat = await ChatService.getChatsId(LoginService().user_info!['id']!);
    List<ChatRoom> chatsrequest = await ChatService.getChats();
    int unreadrequest = await ChatService.getUnreadMessages();
    if (chatsrequest.isEmpty && !loading){
      print("No chats");
      _showAvisNoEsPotCarregarChat();
    }
    else if (loading){
      print("Loading chats");
    }
    print(LoginService().user_info!['id']);
    print("Chats loaded");
    print(chatsrequest);
    print(chats.length);
    print("////////////////");
    print(unreadrequest);
    //print(chat);
    setState(() {
      loading = false;
      chats = chatsrequest;
      _number_new_messages = unreadrequest;
    });

  }

  /*_decrementaUnreadMessage(){
    setState(() {
      _number_new_messages = _number_new_messages - 1;
      if (_number_new_messages < 0){
        _number_new_messages = 0;
      }
    });
  }*/

  _setListMessages(){
    setState(() {
      _getChats();
    });
  }


  Widget ListPoints(BuildContext context, List<ChatRoom> list) {
    return Column(
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    print(_number_new_messages);
                    return CardChatUsersWidget(
                      username: list[index].to_user.username,
                      last_message_received: list[index].last_message,
                      new_message: list[index].unread,
                      last_message_time:  DateFormat('HH:mm').format(list[index].last_sent_time),
                      context: context,
                      room_id: list[index].to_user.id,
                      setejar: _setListMessages,
                    );
                  }
                  ),
                )
            )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
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
                Tab(icon: Icon(Icons.supervised_user_circle), text: "Users"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListPoints(context, chats),
            ],
          ),
        ),
      ),
    );
  }
}
