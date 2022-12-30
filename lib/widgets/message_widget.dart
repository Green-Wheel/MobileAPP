import 'package:flutter/material.dart';
import '../screens/home/widgets/bottom_bar.dart';
import '../screens/home/widgets/drawer.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatefulWidget {
  bool read;
  bool itsmine;
  String message;
  String datesend;
  String dateread;
  MessageWidget({required this.message, required this.itsmine, required this.read, required this.datesend, required this.dateread, super.key});

  @override
  State<StatefulWidget> createState() => _MessageWidget();
}

class _MessageWidget extends State<MessageWidget>{
  @override
  Widget build(BuildContext context) {
    return _messageWidget(widget.message, widget.itsmine, widget.read, widget.datesend, widget.dateread);
  }
}

//TODO: en la screen implementar scroll con mensajes agrupados por dias + acabar de poner formato hora del mensaje bien
main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Chat"), actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            })
      ]),
      body: Column(
        /*child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(20),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _chatBubble(message, isMe, isSameUser);
                },
              ),
            ),
          ],
        ),*/
        children:[
          _messageWidget("Hola shbcdhsadhslabchsdlbchsdlchbdslcvhdslchdslchdslvchdslcbhdslcbhdslcbhslcbhsl", true, false, DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
          _messageWidget("shdkshldhsalssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss", false, true, DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()), DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
        ]
      ),
   //   drawer: SimpleDrawer(),
      floatingActionButton: const BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ),
  ));
}

//direction = true (other user), false = (its me)
Widget greenCheck(bool direction){
  if (direction) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child:  Icon(
        Icons.done_all,
        size: 20,
        color: Colors.blue,
      ),
    );
  }
  else {
    return const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.done_all,
        size: 20,
        color: Colors.blue,
      ),
    );
  }
}



//direction = true (other user), false = (its me)
Widget greyCheck(bool direction){
  if (direction) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Icon(
        Icons.done_all,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
  else{
    return const Padding(
      padding: EdgeInsets.only(right: 10),
      child:  Icon(
        Icons.done_all,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
}


//funcion para mostrar las estrellas
Widget _messageWidget(String message, bool itsmine, bool read, String datesend, String dateread){
  if (!itsmine){
    return Column(
      children:<Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7, // changes position of shadow
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                //fontSize: 16,
              ),
            ),
          )
        ),
        Row(
          children: <Widget>[
            read ? greenCheck(true) : greyCheck(true),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                datesend.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
  else{
    return  Column(
      children:<Widget>[
        Container(
          alignment: Alignment.topRight,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7, // changes position of shadow
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                //fontSize: 16,
              ),
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 2),
              child: Text(
                datesend.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            read ? greenCheck(false) : greyCheck(false),
          ],
        )
      ],
    );
  }
}