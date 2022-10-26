// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      publicationId: json['publicationId'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      confirmed: json['confirmed'] as bool,
      finished: json['finished'] as bool,
      canceled: json['canceled'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'publicationId': instance.publicationId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'confirmed': instance.confirmed,
      'finished': instance.finished,
      'canceled': instance.canceled,
      'createdAt': instance.createdAt.toIso8601String(),
    };
