// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as int?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      publication:
          Publication.fromJson(json['publication'] as Map<String, dynamic>),
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
      confirmed: json['confirmed'] as bool,
      finished: json['finished'] as bool,
      cancelled: json['cancelled'] as bool,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'publication': instance.publication,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'confirmed': instance.confirmed,
      'finished': instance.finished,
      'cancelled': instance.cancelled,
      'created': instance.created.toIso8601String(),
    };

Bookings _$BookingsFromJson(Map<String, dynamic> json) => Bookings(
      count: json['count'] as int,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingsToJson(Bookings instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
