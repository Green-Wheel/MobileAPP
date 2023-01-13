// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      id: json['id'] as int?,
      user: BasicUser.fromJson(json['user'] as Map<String, dynamic>),
      rate: (json['rate'] as num).toDouble(),
      comment: json['comment'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'rate': instance.rate,
      'comment': instance.comment,
      'created_at': instance.created_at.toIso8601String(),
    };
