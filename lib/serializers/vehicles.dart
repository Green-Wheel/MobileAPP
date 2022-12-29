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
    required this.car_brand,
    required this.current_type,
    required this.consumption
  });

  int? id;
  String name;
  int year;
  double autonomy;
  CarBrand car_brand;
  String current_type;
  double consumption;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class Car {
  Car({
    this.id,
    required this.charge_capacity,
    required this.car_license,
    required this.model,
    required this.car_owner,
  });

  int? id;
  double charge_capacity;
  String car_license;
  CarModel model;
  int car_owner;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}
