import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/input_text_message.dart';
import 'package:greenwheel/widgets/rating_stars.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';
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
  bool new_message = true;
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200),
          _cardUsers("Miguel Gutiérrez", 3.5, "last message", new_message),
        ],
      )
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
  return InkWell(
    onTap: () {
      //TODO: implementar ruta de chat
      new_message = false;
    },
    child: SizedBox(
      height: 80,
      child: ListTile(
        shape:  const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        leading: new_message ?  CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Column(
            children: [
             Padding(
               padding: EdgeInsets.only(left: 35),
               child:  CircleAvatar(
                 radius: 6,
                 backgroundColor: Colors.red,
                 //opcional marcar numero de mensajes no vistos
                 //child: Text("1", style: TextStyle(color: Colors.white, fontSize: 10),),
               ),
             ),
              Icon(
                size: 30,
                  color: Colors.green,
                  Icons.person
              ),
            ],
          )
        ): CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(
              size: 30,
              color: Colors.green,
              Icons.person
          ),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        //TODO: retocar width pantalla
                        width: 250,
                        child: Column(
                            children:[
                              Padding(
                                padding: EdgeInsets.only(right: 108),
                                child: Text(username, style: const TextStyle(fontSize: 18, color: Colors.black),),

                              ),
                              //RatingStars(rating: rate_user.toString()),
                              StarsStaticRateWidget(rate: rate_user),
                              //SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(right: 170),
                                child: Text(last_message_received, style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ),
                            ]
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("12:00", style: const TextStyle(fontSize: 15, color: Colors.black),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
