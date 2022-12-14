import 'package:greenwheel/serializers/chargers.dart';
import 'package:greenwheel/serializers/vehicles.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ffi';

part 'users.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    this.email,
    this.about,
    this.profile_picture,
    this.language_id,
    required this.level,
    required this.xp,
    this.rating,
    required this.selected_car,
    required this.trophies
  });

  int? id;
  String username;
  String first_name;
  String last_name;
  String? email;
  String? about;
  String? profile_picture;
  int? language_id;
  int level;
  int xp;
  double? rating;
  int selected_car;
  List trophies;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class BasicUser {
  BasicUser({
    this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    this.profile_picture,
  });

  int? id;
  String username;
  String first_name;
  String last_name;
  String? profile_picture;

  factory BasicUser.fromJson(Map<String, dynamic> json) => _$BasicUserFromJson(json);

  Map<String, dynamic> toJson() => _$BasicUserToJson(this);
}
