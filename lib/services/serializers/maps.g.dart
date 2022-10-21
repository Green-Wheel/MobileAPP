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
