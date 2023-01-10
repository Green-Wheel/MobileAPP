import 'package:greenwheel/serializers/chargers.dart';
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
    required this.id,
    required this.name,
    this.year,
    required this.autonomy,
    required this.car_brand,
    required this.current_type,
    required this.connection_type,
    required this.consumption
  });

  int id;
  String name;
  int? year;
  double autonomy;
  CarBrand car_brand;
  List<CurrentType> current_type;
  List<ConnectionType> connection_type;
  double consumption;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class Car {
  Car({
    this.id,
    required this.alias,
    required this.car_brand
  });

  int? id;
  String alias;
  CarBrand car_brand;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}

@JsonSerializable()
class CarsDetailed {
  CarsDetailed({
    this.id,
    required this.alias,
    required this.car_license,
    required this.charge_capacity,
    required this.model
  });

  int? id;
  String alias;
  String car_license;
  double charge_capacity;
  CarModel model;

  factory CarsDetailed.fromJson(Map<String, dynamic> json) =>
      _$CarsDetailedFromJson(json);

  Map<String, dynamic> toJson() => _$CarsDetailedToJson(this);
}

@JsonSerializable()
class CarBrandYear {
  CarBrandYear({
    this.id,
    required this.name,
    this.year,
  });

  int? id;
  String name;
  int? year;

  factory CarBrandYear.fromJson(Map<String, dynamic> json) =>
      _$CarBrandYearFromJson(json);

  Map<String, dynamic> toJson() => _$CarBrandYearToJson(this);
}