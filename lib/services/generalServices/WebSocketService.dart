import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class NotificationController{
  static final NotificationController _singleton = NotificationController._internal();
  factory NotificationController() => _singleton;

  IOWebSocketChannel? channel;
  late var channelStream = channel?.stream.asBroadcastStream();

  NotificationController._internal(){
    initWebSocketConnection();
  }

  initWebSocketConnection() async {
    print("Connectant..");
    //TODO: connectar amb el servidor de socket
    try{
      channel = IOWebSocketChannel.connect(
        Uri.parse('ws://localhost:3000/chat/'), //ws://localhost:3000/chat/$user_id
        pingInterval: Duration(seconds: 10),
      );
      channelStream?.listen((message) {
        print(message);
      });
    } on Exception catch(e){
      print(e);
      return await initWebSocketConnection();
    }

    print("Socket connected");
    channel?.sink.done.then((dynamic _) => _onDisconnected());

  }

  void _onDisconnected() {
    print("Socket disconnected");
    initWebSocketConnection();
  }

  void SendMessage (String message, int sourceId, int destinationId) {
   try{
      channel?.sink.add(jsonEncode({
        "message": message,
        "sourceId": sourceId,
        "destinationId": destinationId,
      }));
    } on Exception catch(e){
      print(e);
   }
  }

}