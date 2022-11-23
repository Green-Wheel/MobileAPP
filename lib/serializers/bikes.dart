import 'package:json_annotation/json_annotation.dart';

import 'chargers.dart';

part 'bikes.g.dart';


@JsonSerializable()
class BikeType {
  BikeType({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory BikeType.fromJson(Map<String, dynamic> json) =>
      _$BikeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BikeTypeToJson(this);
}


@JsonSerializable()
class Bike {
  Bike({
    this.id,
    required this.localization,
    required this.bike_type,
  });

  int? id;
  Localization localization;
  BikeType bike_type;

  factory Bike.fromJson(Map<String, dynamic> json) =>
      _$BikeFromJson(json);

  Map<String, dynamic> toJson() => _$BikeToJson(this);
}


@JsonSerializable()
class DetailedBikeSerializer {
  DetailedBikeSerializer({
    this.id,
    this.title,
    this.description,
    this.direction,
    required this.localization,
    required this.town,
    this.images,
    this.avg_rating,
    required this.bike_type,
    this.power, // ???????
    required this.price,
  });

  int? id;
  String? title;
  String? description;
  String? direction;
  Localization localization;
  Town town;
  List<ImageSerializer>? images;
  double? avg_rating;
  BikeType bike_type;
  double? power;
  double price;

  factory DetailedBikeSerializer.fromJson(Map<String, dynamic> json) =>
      _$DetailedBikeSerializerFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedBikeSerializerToJson(this);
}


@JsonSerializable()
class BikeList {
  BikeList({
    this.id,
    this.title,
    this.images,
    required this.localization,
    this.avg_rating,
    required this.bike_type,
    required this.price,
  });

  int? id;
  String? title;
  List<ImageSerializer>? images;
  Localization localization;
  double? avg_rating;
  BikeType bike_type;
  double price;

  factory BikeList.fromJson(Map<String, dynamic> json) =>
      _$BikeListFromJson(json);

  Map<String, dynamic> toJson() => _$BikeListToJson(this);
}









