// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentType _$CurrentTypeFromJson(Map<String, dynamic> json) => CurrentType(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CurrentTypeToJson(CurrentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ConnectionType _$ConnectionTypeFromJson(Map<String, dynamic> json) =>
    ConnectionType(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ConnectionTypeToJson(ConnectionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Town _$TownFromJson(Map<String, dynamic> json) => Town(
      id: json['id'] as int?,
      name: json['name'] as String,
      province: Province.fromJson(json['province'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TownToJson(Town instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province': instance.province,
    };

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      direction: json['direction'] as String,
      town: Town.fromJson(json['town'] as Map<String, dynamic>),
      latLng: LatLang.fromJson(json['latLng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'direction': instance.direction,
      'town': instance.town,
      'latLng': instance.latLng,
    };

SpeedType _$SpeedTypeFromJson(Map<String, dynamic> json) => SpeedType(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpeedTypeToJson(SpeedType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Charger _$ChargerFromJson(Map<String, dynamic> json) => Charger(
      id: json['id'] as int?,
      power: json['power'] as String,
      speedType: SpeedType.fromJson(json['speedType'] as Map<String, dynamic>),
      connectionType: ConnectionType.fromJson(
          json['connectionType'] as Map<String, dynamic>),
      currentType:
          CurrentType.fromJson(json['currentType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChargerToJson(Charger instance) => <String, dynamic>{
      'id': instance.id,
      'power': instance.power,
      'speedType': instance.speedType,
      'connectionType': instance.connectionType,
      'currentType': instance.currentType,
    };

PublicCharger _$PublicChargerFromJson(Map<String, dynamic> json) =>
    PublicCharger(
      id: json['id'] as int?,
      charger: Charger.fromJson(json['charger'] as Map<String, dynamic>),
      power: (json['power'] as num).toDouble(),
      speedType: SpeedType.fromJson(json['speedType'] as Map<String, dynamic>),
      connectionType: ConnectionType.fromJson(
          json['connectionType'] as Map<String, dynamic>),
      currentType:
          CurrentType.fromJson(json['currentType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicChargerToJson(PublicCharger instance) =>
    <String, dynamic>{
      'id': instance.id,
      'charger': instance.charger,
      'power': instance.power,
      'speedType': instance.speedType,
      'connectionType': instance.connectionType,
      'currentType': instance.currentType,
    };

PrivateCharger _$PrivateChargerFromJson(Map<String, dynamic> json) =>
    PrivateCharger(
      id: json['id'] as int?,
      charger: Charger.fromJson(json['charger'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$PrivateChargerToJson(PrivateCharger instance) =>
    <String, dynamic>{
      'id': instance.id,
      'charger': instance.charger,
      'price': instance.price,
    };
