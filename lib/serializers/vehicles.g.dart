// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarBrand _$CarBrandFromJson(Map<String, dynamic> json) => CarBrand(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CarBrandToJson(CarBrand instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      id: json['id'] as int,
      name: json['name'] as String,
      year: json['year'] as int?,
      autonomy: (json['autonomy'] as num).toDouble(),
      car_brand: CarBrand.fromJson(json['car_brand'] as Map<String, dynamic>),
      current_type: (json['current_type'] as List<dynamic>)
          .map((e) => CurrentType.fromJson(e as Map<String, dynamic>))
          .toList(),
      connection_type: (json['connection_type'] as List<dynamic>)
          .map((e) => ConnectionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      consumption: (json['consumption'] as num).toDouble(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'autonomy': instance.autonomy,
      'car_brand': instance.car_brand,
      'current_type': instance.current_type,
      'connection_type': instance.connection_type,
      'consumption': instance.consumption,
    };

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['id'] as int?,
      alias: json['alias'] as String,
      car_brand: CarBrand.fromJson(json['car_brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'alias': instance.alias,
      'car_brand': instance.car_brand,
    };

CarsDetailed _$CarsDetailedFromJson(Map<String, dynamic> json) => CarsDetailed(
      id: json['id'] as int?,
      alias: json['alias'] as String,
      car_license: json['car_license'] as String,
      charge_capacity: (json['charge_capacity'] as num).toDouble(),
      model: CarModel.fromJson(json['model'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarsDetailedToJson(CarsDetailed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alias': instance.alias,
      'car_license': instance.car_license,
      'charge_capacity': instance.charge_capacity,
      'model': instance.model,
    };

CarBrandYear _$CarBrandYearFromJson(Map<String, dynamic> json) => CarBrandYear(
      id: json['id'] as int?,
      name: json['name'] as String,
      year: json['year'] as int?,
    );

Map<String, dynamic> _$CarBrandYearToJson(CarBrandYear instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
    };
