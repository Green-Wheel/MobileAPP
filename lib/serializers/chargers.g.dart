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
      child: Publication.fromJson(json['child'] as Map<String, dynamic>),
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

Localization _$LocalizationFromJson(Map<String, dynamic> json) => Localization(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocalizationToJson(Localization instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Charger _$ChargerFromJson(Map<String, dynamic> json) => Charger(
      id: json['id'] as int?,
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      charger_type: json['charger_type'] as String,
    );

Map<String, dynamic> _$ChargerToJson(Charger instance) => <String, dynamic>{
      'id': instance.id,
      'localization': instance.localization,
      'charger_type': instance.charger_type,
    };

ChargerList _$ChargerListFromJson(Map<String, dynamic> json) => ChargerList(
      id: json['id'] as int?,
      title: json['title'] as String?,
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      connection_type: (json['connection_type'] as List<dynamic>)
          .map((e) => ConnectionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      avg_rating: (json['avg_rating'] as num).toDouble(),
      charger_type: json['charger_type'] as String,
      child: Charger.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChargerListToJson(ChargerList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'localization': instance.localization,
      'connection_type': instance.connection_type,
      'avg_rating': instance.avg_rating,
      'charger_type': instance.charger_type,
      'child': instance.child,
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
      price: (json['price'] as num).toDouble(),
      owner: BasicUser.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivateChargerToJson(PrivateCharger instance) =>
    <String, dynamic>{
      'price': instance.price,
      'owner': instance.owner,
    };

DetailedCharherSerializer _$DetailedCharherSerializerFromJson(
        Map<String, dynamic> json) =>
    DetailedCharherSerializer(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      direction: json['direction'] as String?,
      localization:
          Localization.fromJson(json['localization'] as Map<String, dynamic>),
      town: Town.fromJson(json['town'] as Map<String, dynamic>),
      connection_type: (json['connection_type'] as List<dynamic>)
          .map((e) => ConnectionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      current_type: (json['current_type'] as List<dynamic>)
          .map((e) => CurrentType.fromJson(e as Map<String, dynamic>))
          .toList(),
      speed: (json['speed'] as List<dynamic>)
          .map((e) => SpeedType.fromJson(e as Map<String, dynamic>))
          .toList(),
      power: (json['power'] as num?)?.toDouble(),
      avg_rating: (json['avg_rating'] as num?)?.toDouble(),
      charger_type: json['charger_type'] as String,
      child: Charger.fromJson(json['child'] as Map<String, dynamic>),
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
      'connection_type': instance.connection_type,
      'current_type': instance.current_type,
      'speed': instance.speed,
      'power': instance.power,
      'avg_rating': instance.avg_rating,
      'charger_type': instance.charger_type,
      'child': instance.child,
    };
