// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginMethods _$LoginMethodsFromJson(Map<String, dynamic> json) => LoginMethods(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LoginMethodsToJson(LoginMethods instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Languages _$LanguagesFromJson(Map<String, dynamic> json) => Languages(
      id: json['id'] as int?,
      shortName: json['shortName'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LanguagesToJson(Languages instance) => <String, dynamic>{
      'id': instance.id,
      'shortName': instance.shortName,
      'name': instance.name,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      about: json['about'] as String?,
      profile_picture: json['profile_picture'] as String?,
      language_id: json['language_id'] as int?,
      level: json['level'] as int?,
      xp: json['xp'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'about': instance.about,
      'language_id': instance.language_id,
      'profile_picture': instance.profile_picture,
      'level': instance.level,
      'xp': instance.xp,
      'rating': instance.rating,
    };
