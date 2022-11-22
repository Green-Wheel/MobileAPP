import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class LoginMethods {
  LoginMethods({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory LoginMethods.fromJson(Map<String, dynamic> json) =>
      _$LoginMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginMethodsToJson(this);
}

@JsonSerializable()
class Languages {
  Languages({
    this.id,
    required this.shortName,
    required this.name,
  });

  int? id;
  String shortName;
  String name;

  factory Languages.fromJson(Map<String, dynamic> json) =>
      _$LanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagesToJson(this);
}

@JsonSerializable()
class User {
  User({
    this.id,
    this.username,
    this.first_name,
    this.last_name,
    this.about,
    this.profile_picture,
    this.language_id,
    this.level,
    this.xp,
    this.rating,
  });

  int? id;
  String? username;
  String? first_name;
  String? last_name;
  String? about;
  int? language_id;
  String? profile_picture;
  int? level;
  int? xp;
  double? rating;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
