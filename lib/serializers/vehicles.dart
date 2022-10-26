import 'package:json_annotation/json_annotation.dart';

part 'vehicles.g.dart';

@JsonSerializable()
class CarBrand {
  CarBrand({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory CarBrand.fromJson(Map<String, dynamic> json) =>
      _$CarBrandFromJson(json);

  Map<String, dynamic> toJson() => _$CarBrandToJson(this);
}

@JsonSerializable()
class CarModel {
  CarModel({
    this.id,
    required this.name,
    required this.year,
    required this.autonomy,
    required this.brand,
  });

  int? id;
  String name;
  int year;
  double autonomy;
  CarBrand brand;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class Car {
  Car({
    this.id,
    required this.name,
    required this.capacity,
    required this.license,
    required this.model,
    required this.owner,
  });

  int? id;
  String name;
  double capacity;
  String license;
  CarModel model;
  int owner;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}
