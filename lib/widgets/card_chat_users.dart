import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/username_rating_stars.dart';

class CardChatUsersWidget extends StatefulWidget {
  String username;
  double rate_user;
  String last_message_received;
  bool new_message;
  CardChatUsersWidget({Key? key, required this.username, required this.rate_user, required this.last_message_received, required this.new_message}) : super(key: key);

  @override
  State<CardChatUsersWidget> createState() => _CardChatUsersWidget();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: _cardUsers("username", 4.0, "last message", true),
    ),
  ),
  );
}

class _CardChatUsersWidget extends State<CardChatUsersWidget> {
  @override
  Widget build(BuildContext context) {
    return _cardUsers(widget.username, widget.rate_user, widget.last_message_received, widget.new_message);
  }
}

Widget _cardUsers(String username, double rate_user, String last_message_received, bool new_message) {
  //TODO: passar context
  return ListTile(
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    leading: new_message ?  CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(
          color: Colors.green,
          Icons.person
      ),
    ): CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(
          color: Colors.blue,
          Icons.person
      ),
    ),
    //TODO: Acabar user list
    //title: Username_Rating(username: username, rating: rate_user.toString(), edit_button: false),
    subtitle: Text(last_message_received, style: TextStyle(fontSize: 10, color: Colors.grey)),
  );
}

/*
        Row(
        children: [
            SizedBox(
            width: 100,
            child: Column(
              children: [
                new_message ?  CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                      color: Colors.green,
                      Icons.person
                  ),
                ): CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                      color: Colors.blue,
                      Icons.person
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Username_Rating(username: username, rating: rate_user.toString(), edit_button: false),
                ],
              ),
              Row(
                children: [
                  //TODO: falta padding
                  Text(last_message_received, style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
*/