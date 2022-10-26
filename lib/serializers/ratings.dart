import 'package:json_annotation/json_annotation.dart';

import 'bookings.dart';

part 'ratings.g.dart';

@JsonSerializable()
class Rating {
  Rating({
    this.id,
    required this.rate,
    required this.comment,
    required this.booking,
  });

  int? id;
  double rate;
  String comment;
  Booking booking;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
