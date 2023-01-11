import 'package:greenwheel/serializers/users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatRoom {
  ChatRoom ({
    required this.id,
    required this.to_user,
    required this.last_message,
    required this.last_sent_time,
    required this.last_sent_user,
    required this.unread,
  });

  int id;
  BasicUser to_user;
  String last_message;
  DateTime last_sent_time;
  String last_sent_user;
  bool unread;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}


@JsonSerializable()
class ChatRoomMessage {
  ChatRoomMessage ({
    required this.id,
    required this.sender,
    required this.content,
    required this.created_at,
  });

  int id;
  BasicUser sender;
  String content;
  DateTime created_at;

  factory ChatRoomMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomMessageToJson(this);
}


@JsonSerializable()
class SocketMessages{
  SocketMessages ({
    required this.id,
    required this.room_id,
    required this.sender,
    required this.content,
    required this.created_at,

  });

  int id;
  String room_id;
  BasicUser sender;
  String content;
  DateTime created_at;

  factory SocketMessages.fromJson(Map<String, dynamic> json) =>
      _$SocketMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$SocketMessagesToJson(this);
}