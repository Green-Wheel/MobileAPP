// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as int?,
      user: BasicUser.fromJson(json['user'] as Map<String, dynamic>),
      publication:
          Publication.fromJson(json['publication'] as Map<String, dynamic>),
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'publication': instance.publication,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'created': instance.created.toIso8601String(),
    };
