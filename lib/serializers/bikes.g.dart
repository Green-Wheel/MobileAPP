// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bikes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BikeType _$BikeTypeFromJson(Map<String, dynamic> json) => BikeType(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BikeTypeToJson(BikeType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Bike _$BikeFromJson(Map<String, dynamic> json) => Bike(
      id: json['id'] as int?,
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      bike_type: json['bike_type'] as int,
    );

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'id': instance.id,
      'localization': instance.localization,
      'bike_type': instance.bike_type,
    };

DetailedBikeSerializer _$DetailedBikeSerializerFromJson(
        Map<String, dynamic> json) =>
    DetailedBikeSerializer(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      direction: json['direction'] as String?,
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      town: Town.fromJson(json['town'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageSerializer.fromJson(e as Map<String, dynamic>))
          .toList(),
      avg_rating: (json['avg_rating'] as num?)?.toDouble(),
      bike_type: BikeType.fromJson(json['bike_type'] as Map<String, dynamic>),
      power: (json['power'] as num?)?.toDouble(),
      price: (json['price'] as num).toDouble(),
      contamination: json['contamination'] as String,
    );

Map<String, dynamic> _$DetailedBikeSerializerToJson(
        DetailedBikeSerializer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'direction': instance.direction,
      'localization': instance.localization,
      'town': instance.town,
      'images': instance.images,
      'avg_rating': instance.avg_rating,
      'bike_type': instance.bike_type,
      'power': instance.power,
      'price': instance.price,
      'contamination': instance.contamination,
    };

BikeList _$BikeListFromJson(Map<String, dynamic> json) => BikeList(
      id: json['id'] as int?,
      title: json['title'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageSerializer.fromJson(e as Map<String, dynamic>))
          .toList(),
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      avg_rating: (json['avg_rating'] as num?)?.toDouble(),
      bike_type: BikeType.fromJson(json['bike_type'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      contamination: json['contamination'] as String,
    );

Map<String, dynamic> _$BikeListToJson(BikeList instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'localization': instance.localization,
      'avg_rating': instance.avg_rating,
      'bike_type': instance.bike_type,
      'price': instance.price,
      'contamination': instance.contamination,
    };
