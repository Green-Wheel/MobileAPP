// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      id: json['id'] as int,
      to_users: BasicUser.fromJson(json['to_users'] as Map<String, dynamic>),
      last_message: json['last_message'] as String,
      last_sent_time: DateTime.parse(json['last_sent_time'] as String),
      last_sent_user: json['last_sent_user'] as String,
      open: json['open'] as bool,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'to_users': instance.to_users,
      'last_message': instance.last_message,
      'last_sent_time': instance.last_sent_time.toIso8601String(),
      'last_sent_user': instance.last_sent_user,
      'open': instance.open,
      'read': instance.read,
    };

ChatRoomMessage _$ChatRoomMessageFromJson(Map<String, dynamic> json) =>
    ChatRoomMessage(
      id: json['id'] as int,
      sender: BasicUser.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ChatRoomMessageToJson(ChatRoomMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'content': instance.content,
      'created_at': instance.created_at.toIso8601String(),
    };

SocketMessages _$SocketMessagesFromJson(Map<String, dynamic> json) =>
    SocketMessages(
      id: json['id'] as int,
      room_id: json['room_id'] as String,
      sender: BasicUser.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SocketMessagesToJson(SocketMessages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.room_id,
      'sender': instance.sender,
      'content': instance.content,
      'created_at': instance.created_at.toIso8601String(),
    };
