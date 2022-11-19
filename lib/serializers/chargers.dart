import 'package:json_annotation/json_annotation.dart';

import './maps.dart';

part 'chargers.g.dart';

@JsonSerializable()
class CurrentType {
  CurrentType({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory CurrentType.fromJson(Map<String, dynamic> json) =>
      _$CurrentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTypeToJson(this);
}

@JsonSerializable()
class ConnectionType {
  ConnectionType({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory ConnectionType.fromJson(Map<String, dynamic> json) =>
      _$ConnectionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionTypeToJson(this);
}

@JsonSerializable()
class Province {
  Province({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}

@JsonSerializable()
class Town {
  Town({
    this.id,
    required this.name,
    required this.province,
  });

  int? id;
  String name;
  Province province;

  factory Town.fromJson(Map<String, dynamic> json) => _$TownFromJson(json);

  Map<String, dynamic> toJson() => _$TownToJson(this);
}

@JsonSerializable()
class Publication {
  Publication({
    this.id,
    required this.type,
    required this.child
  });

  int? id;
  String type;
  DetailedCharherSerializer child;

  factory Publication.fromJson(Map<String, dynamic> json) =>
      _$PublicationFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationToJson(this);
}

@JsonSerializable()
class SpeedType {
  SpeedType({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory SpeedType.fromJson(Map<String, dynamic> json) =>
      _$SpeedTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SpeedTypeToJson(this);
}

@JsonSerializable()
class Charger {
  Charger({
    this.id,
    required this.location,
    required this.chargerType,
  });

  int? id;
  LatLang location;
  String chargerType;

  factory Charger.fromJson(Map<String, dynamic> json) =>
      _$ChargerFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerToJson(this);
}

@JsonSerializable()
class PublicCharger {
  PublicCharger({
    this.agent,
    this.identifier,
    this.access,
    this.available,
  });

  String? agent;
  String? identifier;
  String? access;
  bool? available;

  factory PublicCharger.fromJson(Map<String, dynamic> json) =>
      _$PublicChargerFromJson(json);

  Map<String, dynamic> toJson() => _$PublicChargerToJson(this);
}

//TODO: Change owner from id to BasicUserInfoSerializer
@JsonSerializable()
class PrivateCharger {
  PrivateCharger({
    this.owner,
    required this.price,
  });

  int? owner;
  double price;

  factory PrivateCharger.fromJson(Map<String, dynamic> json) =>
      _$PrivateChargerFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateChargerToJson(this);
}

@JsonSerializable()
class DetailedCharherSerializer {
  DetailedCharherSerializer({
    this.id,
    this.title,
    this.description,
    this.direction,
    required this.localization,
    required this.town,
    required this.connectionType,
    required this.currentType,
    required this.speed,
    this.power,
    required this.avg_rating,
    required this.charger_type,
    required this.child,
  });

  int? id;
  String? title;
  String? description;
  String? direction;
  LatLang localization;
  Town town;
  ConnectionType connectionType;
  CurrentType currentType;
  SpeedType speed;
  int? power;
  double avg_rating;
  String charger_type;
  PrivateCharger child;


  factory DetailedCharherSerializer.fromJson(Map<String, dynamic> json) =>
      _$DetailedCharherSerializerFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedCharherSerializerToJson(this);
}
