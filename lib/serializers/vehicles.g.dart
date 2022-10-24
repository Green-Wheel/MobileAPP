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
      brand: CarBrand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'autonomy': instance.autonomy,
      'brand': instance.brand,
    };

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['id'] as int?,
      name: json['name'] as String,
      capacity: (json['capacity'] as num).toDouble(),
      license: json['license'] as String,
      model: CarModel.fromJson(json['model'] as Map<String, dynamic>),
      owner: json['owner'] as int,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity': instance.capacity,
      'license': instance.license,
      'model': instance.model,
      'owner': instance.owner,
    };
