import 'dart:async';
import 'dart:convert';
import 'package:greenwheel/services/backendServices/user_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
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
    int userId = LoginService().user_info!['id'];
    try{
      channel = IOWebSocketChannel.connect(
        Uri.parse('ws://3.250.219.80/ws/$userId/chats/messages/'), //ws://localhost:3000/chat/$user_id
        pingInterval: Duration(seconds: 10),
      );
      channelStream?.listen((message) {
        //TODO: rebo el missatge, falta fer la crida corresponent i transformació serializer
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

  void SendMessage (String message, int id_user){
  //TODO: canviar user_id
   try{
      channel?.sink.add(jsonEncode({
        "message": message,
        "to_user": 2,
      }));
    } on Exception catch(e){
      print(e);
   }
  }

}