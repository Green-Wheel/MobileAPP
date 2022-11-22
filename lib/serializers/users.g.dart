// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      about: json['about'] as String?,
      profile_picture: json['profile_picture'] == null
          ? null
          : ImageSerializer.fromJson(
              json['profile_picture'] as Map<String, dynamic>),
      language_id: json['language_id'] as int,
      level: json['level'] as int,
      xp: json['xp'] as int,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'about': instance.about,
      'profile_picture': instance.profile_picture,
      'language_id': instance.language_id,
      'level': instance.level,
      'xp': instance.xp,
      'rating': instance.rating,
    };

BasicUser _$BasicUserFromJson(Map<String, dynamic> json) => BasicUser(
      id: json['id'] as int?,
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      profile_picture: json['profile_picture'] as String,
    );

Map<String, dynamic> _$BasicUserToJson(BasicUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile_picture': instance.profile_picture,
    };
