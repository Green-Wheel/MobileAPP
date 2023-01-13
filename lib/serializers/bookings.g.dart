// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingStatus _$BookingStatusFromJson(Map<String, dynamic> json) =>
    BookingStatus(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BookingStatusToJson(BookingStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as int?,
      user: BasicUser.fromJson(json['user'] as Map<String, dynamic>),
      publication:
          Publication.fromJson(json['publication'] as Map<String, dynamic>),
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
      status: BookingStatus.fromJson(json['status'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'publication': instance.publication,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'status': instance.status,
      'created': instance.created.toIso8601String(),
    };
