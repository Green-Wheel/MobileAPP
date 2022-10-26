// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      id: json['id'] as int?,
      rate: (json['rate'] as num).toDouble(),
      comment: json['comment'] as String,
      booking: Booking.fromJson(json['booking'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'rate': instance.rate,
      'comment': instance.comment,
      'booking': instance.booking,
    };
