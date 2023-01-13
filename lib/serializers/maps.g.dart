// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLang _$LatLangFromJson(Map<String, dynamic> json) => LatLang(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLangToJson(LatLang instance) => <String, dynamic>{
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

Direction _$DirectionFromJson(Map<String, dynamic> json) => Direction(
      distance: json['distance'] as String,
      duration: json['duration'] as String,
      endAddress: json['endAddress'] as String,
      endLocation:
          LatLang.fromJson(json['endLocation'] as Map<String, dynamic>),
      startAddress: json['startAddress'] as String,
      startLocation:
          LatLang.fromJson(json['startLocation'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Steps.fromJson(e as Map<String, dynamic>))
          .toList(),
      polylinePoints: (json['polylinePoints'] as List<dynamic>)
          .map((e) => LatLang.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DirectionToJson(Direction instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'endAddress': instance.endAddress,
      'endLocation': instance.endLocation,
      'startAddress': instance.startAddress,
      'startLocation': instance.startLocation,
      'steps': instance.steps,
      'polylinePoints': instance.polylinePoints,
    };

Steps _$StepsFromJson(Map<String, dynamic> json) => Steps(
      distance: json['distance'] as String,
      duration: json['duration'] as String,
      endLocation:
          LatLang.fromJson(json['endLocation'] as Map<String, dynamic>),
      htmlInstructions: json['htmlInstructions'] as String,
      startLocation:
          LatLang.fromJson(json['startLocation'] as Map<String, dynamic>),
      travelMode: json['travelMode'] as String,
    );

Map<String, dynamic> _$StepsToJson(Steps instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'endLocation': instance.endLocation,
      'htmlInstructions': instance.htmlInstructions,
      'startLocation': instance.startLocation,
      'travelMode': instance.travelMode,
    };
