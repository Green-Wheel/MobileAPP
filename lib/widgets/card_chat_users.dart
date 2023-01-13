import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/chat.dart';


class CardChatUsersWidget extends StatefulWidget {
  String username;
  String last_message_received;
  bool new_message;
  String last_message_time;
  BuildContext context;
  int? to_user_id;

  //Function? setejar;

  //opcion leido del usuario en el doublecheck
  CardChatUsersWidget(
      {Key? key,
      required this.username,
      required this.last_message_received,
      required this.new_message,
      required this.last_message_time,
      required this.to_user_id,
      required this.context})
      : super(key: key);

  @override
  State<CardChatUsersWidget> createState() => _CardChatUsersWidget();
}


class _CardChatUsersWidget extends State<CardChatUsersWidget> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print(widget.room_id);

        //decrementar unread + cridar a la api
        //widget.setejar!();
        ChatService.putUnreadMessage(widget.to_user_id!);

        GoRouter.of(context).push('/chats/${widget.to_user_id!}');
        widget.new_message = false;
      },
      child: SizedBox(
          height: MediaQuery.of(widget.context).size.height * 0.1,
          width: MediaQuery.of(widget.context).size.width,
          child: Column (
            children: [
              ListTile(
                leading: widget.new_message
                    ? CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.green[100],
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(
                                  size: 30, color: Colors.green, Icons.person),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:35),
                          child:  CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.red,
                            //opcional marcar numero de mensajes no vistos
                            //child: Text("1", style: TextStyle(color: Colors.white, fontSize: 10),),
                          ),
                        ),
                      ],
                    )
                ): CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.green[100],
                  child: Icon(
                      size: 30,
                      color: Colors.green,
                      Icons.person
                  ),
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(widget.context).size.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.new_message
                              ? Text(
                                  widget.username,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  widget.username,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                          SizedBox(height: 4),
                          Row(
                              children:[
                                Icon(
                                  Icons.done_all,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                SizedBox(width: MediaQuery.of(context).size.width *0.4,
                                  child: Text(widget.last_message_received, style: TextStyle(fontSize: 14, color: Colors.grey)),
                                ),
                              ]
                          )
                        ],
                      ),
                    )
                  ],
                ),
                trailing: Text(widget.last_message_time, style: const TextStyle(fontSize: 15, color: Colors.black),),
              ),
            ],
          )
      ),
    );
  }
}


