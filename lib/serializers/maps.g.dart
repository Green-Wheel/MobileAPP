// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

DistanceMatrix _$DistanceMatrixFromJson(Map<String, dynamic> json) =>
    DistanceMatrix(
      distance: json['distance'] as String,
      duration: json['duration'] as String,
    );

Map<String, dynamic> _$DistanceMatrixToJson(DistanceMatrix instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String,
      streetNumber: json['streetNumber'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'streetNumber': instance.streetNumber,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'province': instance.province,
      'country': instance.country,
    };
