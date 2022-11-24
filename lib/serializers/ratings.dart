import 'dart:ffi';

import 'package:greenwheel/serializers/users.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bookings.dart';

part 'ratings.g.dart';

@JsonSerializable()
class Rating {
  Rating({
    this.id,
    required this.user,
    required this.rate,
    this.comment,
    required this.created_at,
  });

  int? id;
  BasicUser user;
  double rate;
  String? comment;
  DateTime created_at;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
