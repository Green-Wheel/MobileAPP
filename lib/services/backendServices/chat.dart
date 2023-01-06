import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/serializers/chat.dart';

class ChatService {
  static Future<List<ChatRoom>> getChats() async {
    List<ChatRoom> result = [];
    await BackendService.get('chats/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => ChatRoom.fromJson(e)).toList();
      } else {
        print('Error getting chats!');
      }
    });
    return result;
  }

  /*
  static Future<List<ChatRoom>> getChatsByChatId(int chatId) async {
    List<ChatRoom> result = [];
    await BackendService.get('chats/?id_chat=$chatId').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => ChatRoom.fromJson(e)).toList();
      } else {
        print('Error getting chats!');
      }
    });
    return result;
  }


  static Future<ChatRoom> getChatById(int chatId) async {
    ChatRoom result = ChatRoom();
    await BackendService.get('chat/$chatId/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = ChatRoom.fromJson(jsonResponse);
      } else {
        print('Error getting chat!');
      }
    });
    return result;
  }

  static Future<ChatRoom> createChat(int userId, int chargerId) async {
    ChatRoom result = Chat();
    await BackendService.post('chat/', {
      'user': userId,
      'charger': chargerId,
    }).then((response) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        result = Chat.fromJson(jsonResponse);
      } else {
        print('Error creating chat!');
      }
    });
    return result;
  }*/

}