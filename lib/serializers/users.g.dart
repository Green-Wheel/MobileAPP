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
      email: json['email'] as String?,
      about: json['about'] as String?,
      profile_picture: json['profile_picture'] as String?,
      language_id: json['language_id'] as int?,
      level: json['level'] as int,
      xp: json['xp'] as int,
      rating: (json['rating'] as num?)?.toDouble(),
      selected_car: json['selected_car'] as int,
      trophies: json['trophies'] as List<dynamic>,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'about': instance.about,
      'profile_picture': instance.profile_picture,
      'language_id': instance.language_id,
      'level': instance.level,
      'xp': instance.xp,
      'rating': instance.rating,
      'selected_car': instance.selected_car,
      'trophies': instance.trophies,
    };

BasicUser _$BasicUserFromJson(Map<String, dynamic> json) => BasicUser(
      id: json['id'] as int?,
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      profile_picture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$BasicUserToJson(BasicUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile_picture': instance.profile_picture,
    };
