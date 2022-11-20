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
      type: json['type'] as String,
      child: DetailedCharherSerializer.fromJson(
          json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'child': instance.child,
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
      location: LatLang.fromJson(json['location'] as Map<String, dynamic>),
      chargerType: json['chargerType'] as String,
    );

Map<String, dynamic> _$ChargerToJson(Charger instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'chargerType': instance.chargerType,
    };

PublicCharger _$PublicChargerFromJson(Map<String, dynamic> json) =>
    PublicCharger(
      agent: json['agent'] as String?,
      identifier: json['identifier'] as String?,
      access: json['access'] as String?,
      available: json['available'] as bool?,
    );

Map<String, dynamic> _$PublicChargerToJson(PublicCharger instance) =>
    <String, dynamic>{
      'agent': instance.agent,
      'identifier': instance.identifier,
      'access': instance.access,
      'available': instance.available,
    };

PrivateCharger _$PrivateChargerFromJson(Map<String, dynamic> json) =>
    PrivateCharger(
      owner: json['owner'] as int?,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$PrivateChargerToJson(PrivateCharger instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'price': instance.price,
    };

DetailedCharherSerializer _$DetailedCharherSerializerFromJson(
        Map<String, dynamic> json) =>
    DetailedCharherSerializer(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      direction: json['direction'] as String?,
      localization:
          LatLang.fromJson(json['localization'] as Map<String, dynamic>),
      town: Town.fromJson(json['town'] as Map<String, dynamic>),
      connectionType: ConnectionType.fromJson(
          json['connectionType'] as Map<String, dynamic>),
      currentType:
          CurrentType.fromJson(json['currentType'] as Map<String, dynamic>),
      speed: SpeedType.fromJson(json['speed'] as Map<String, dynamic>),
      power: json['power'] as int?,
      avg_rating: (json['avg_rating'] as num).toDouble(),
      charger_type: json['charger_type'] as String,
      child: PrivateCharger.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailedCharherSerializerToJson(
        DetailedCharherSerializer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'direction': instance.direction,
      'localization': instance.localization,
      'town': instance.town,
      'connectionType': instance.connectionType,
      'currentType': instance.currentType,
      'speed': instance.speed,
      'power': instance.power,
      'avg_rating': instance.avg_rating,
      'charger_type': instance.charger_type,
      'child': instance.child,
    };
