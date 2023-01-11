import 'dart:ffi';

import 'package:greenwheel/serializers/users.dart';
import 'package:json_annotation/json_annotation.dart';

import './maps.dart';
import 'bikes.dart';

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
    this.charger,
    this.bike
    //required this.bike
  });

  int? id;
  String type;
  DetailedCharherSerializer? charger;
  DetailedBikeSerializer? bike;
  //BikeDetailedSerializer bike;

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
class Localization {
  Localization({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Localization.fromJson(Map<String, dynamic> json) =>
      _$LocalizationFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationToJson(this);
}

@JsonSerializable()
class Charger {
  Charger({
    this.id,
    required this.localization,
    required this.charger_type,
  });

  int? id;
  Localization localization;
  String charger_type;

  factory Charger.fromJson(Map<String, dynamic> json) =>
      _$ChargerFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerToJson(this);
}

@JsonSerializable()
class ChargerList {
  ChargerList({
    this.id,
    this.title,
    required this.localization,
    required this.connection_type,
    this.avg_rating,
    this.images,
    required this.charger_type,
    this.public,
    this.private,
    required this.contamination
  });

  int? id;
  String? title;
  Localization localization;
  List<ConnectionType> connection_type;
  double? avg_rating;
  List<ImageSerializer>? images;
  String charger_type;
  PublicCharger? public;
  PrivateCharger? private;
  String contamination;

  factory ChargerList.fromJson(Map<String, dynamic> json) =>
      _$ChargerListFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerListToJson(this);
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


@JsonSerializable()
class PrivateCharger {
  PrivateCharger({
    required this.price,
    required this.owner,
  });

  double price;
  BasicUser owner;

  factory PrivateCharger.fromJson(Map<String, dynamic> json) =>
      _$PrivateChargerFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateChargerToJson(this);
}


@JsonSerializable()
class ImageSerializer {
  ImageSerializer({
    this.id,
    required this.url,
  });

  int? id;
  String url;

  factory ImageSerializer.fromJson(Map<String, dynamic> json) =>
      _$ImageSerializerFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSerializerToJson(this);
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
    required this.connection_type,
    required this.current_type,
    required this.speed,
    this.power,
    this.images,
    this.avg_rating,
    required this.charger_type,
    this.public,
    this.private,
    //required this.contamination
  });

  int? id;
  String? title;
  String? description;
  String? direction;
  Localization localization;
  Town town;
  List<ConnectionType> connection_type;
  List<CurrentType> current_type;
  List<SpeedType> speed;
  double? power;
  List<ImageSerializer>? images;
  double? avg_rating;
  String charger_type;
  PublicCharger? public;
  PrivateCharger? private;
  //String contamination;


  factory DetailedCharherSerializer.fromJson(Map<String, dynamic> json) =>
      _$DetailedCharherSerializerFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedCharherSerializerToJson(this);
}
