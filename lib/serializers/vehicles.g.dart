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
      id: json['id'] as int?,
      name: json['name'] as String,
      year: json['year'] as int,
      autonomy: (json['autonomy'] as num).toDouble(),
      car_brand: CarBrand.fromJson(json['car_brand'] as Map<String, dynamic>),
      current_type: json['current_type'] as String,
      consumption: (json['consumption'] as num).toDouble(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'autonomy': instance.autonomy,
      'car_brand': instance.car_brand,
      'current_type': instance.current_type,
      'consumption': instance.consumption,
    };

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['id'] as int?,
      charge_capacity: (json['charge_capacity'] as num).toDouble(),
      car_license: json['car_license'] as String,
      model: CarModel.fromJson(json['model'] as Map<String, dynamic>),
      car_owner: json['car_owner'] as int,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'charge_capacity': instance.charge_capacity,
      'car_license': instance.car_license,
      'model': instance.model,
      'car_owner': instance.car_owner,
    };
