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
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      isStaff: json['isStaff'] as bool,
      isActive: json['isActive'] as bool,
      dateJoined: DateTime.parse(json['dateJoined'] as String),
      about: json['about'] as String,
      profilePicture: json['profilePicture'] as String,
      language: Languages.fromJson(json['language'] as Map<String, dynamic>),
      loginMethod:
          LoginMethods.fromJson(json['loginMethod'] as Map<String, dynamic>),
      level: json['level'] as int,
      xp: json['xp'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'isStaff': instance.isStaff,
      'isActive': instance.isActive,
      'dateJoined': instance.dateJoined.toIso8601String(),
      'about': instance.about,
      'profilePicture': instance.profilePicture,
      'language': instance.language,
      'loginMethod': instance.loginMethod,
      'level': instance.level,
      'xp': instance.xp,
    };
