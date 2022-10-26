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
    required this.lastLogin,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.about,
    required this.profilePicture,
    required this.language,
    required this.loginMethod,
    required this.level,
    required this.xp,
  });

  int? id;
  DateTime? lastLogin;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  String about;
  String profilePicture;
  Languages language;
  LoginMethods loginMethod;
  int level;
  int xp;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
