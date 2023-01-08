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

  static Future<ChatRoom?> getChatsId(int? to_user) async {
    ChatRoom? result;
    await BackendService.get('chats/$to_user').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = ChatRoom.fromJson(jsonResponse);
      } else {
        print('Error getting chats!');
      }
    });
    print(result);
    return result;
  }

  static Future<bool> postChat(Map<String, dynamic> data) async{
    try {
      var response = await BackendService.post('chats/${data['id']}/', data);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<ChatRoomMessage>> getChatMessages(int to_user) async {
    List<ChatRoomMessage> result = [];
    await BackendService.get('chats/$to_user/messages').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => ChatRoomMessage.fromJson(e)).toList();
      } else {
        print('Error getting chats!');
      }
    });
    return result;
  }

  static Future<bool> postMessages(Map<String, dynamic> data) async{
    try {
      var response = await BackendService.post('chats/${data['id']}/messages', data);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static ChatRoom? deleteChat(int to_user) {
    ChatRoom? result;
    BackendService.delete('chats/$to_user/').then((response) {
      if (response.statusCode == 204) {
        var jsonResponse = jsonDecode(response.body);
        result = ChatRoom.fromJson(jsonResponse);
      } else {
        print('Error deleting chat!');
      }
    });
    return result;
  }

  static Future<int> getUnreadMessages() async {
    int result = 0;
    await BackendService.get('chats/unread/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        result = jsonResponse['unreads'];
      } else {
        print('Error getting unread messages!');
      }
    });
    return result;
  }

  static Future<bool> putUnreadMessage(int chat_id) async {
    try {
      var response = await BackendService.put('chargers/unread/$chat_id/', {});
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }


}