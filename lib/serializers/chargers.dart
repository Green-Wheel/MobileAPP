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
    required this.title,
    required this.description,
    required this.direction,
    required this.town,
    required this.latLng,
  });

  int? id;
  String title;
  String description;
  String direction;
  Town town;
  LatLng latLng;

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
    required this.power,
    required this.speedType,
    required this.connectionType,
    required this.currentType,
  });

  int? id;
  String power;
  SpeedType speedType;
  ConnectionType connectionType;
  CurrentType currentType;

  factory Charger.fromJson(Map<String, dynamic> json) =>
      _$ChargerFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerToJson(this);
}

@JsonSerializable()
class PublicCharger {
  PublicCharger({
    this.id,
    required this.charger,
    required this.power,
    required this.speedType,
    required this.connectionType,
    required this.currentType,
  });

  int? id;
  Charger charger;
  double power;
  SpeedType speedType;
  ConnectionType connectionType;
  CurrentType currentType;

  factory PublicCharger.fromJson(Map<String, dynamic> json) =>
      _$PublicChargerFromJson(json);

  Map<String, dynamic> toJson() => _$PublicChargerToJson(this);
}

@JsonSerializable()
class PrivateCharger {
  PrivateCharger({
    this.id,
    required this.charger,
    required this.price,
  });

  int? id;
  Charger charger;
  double price;

  factory PrivateCharger.fromJson(Map<String, dynamic> json) =>
      _$PrivateChargerFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateChargerToJson(this);
}
