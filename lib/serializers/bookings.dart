import 'package:greenwheel/serializers/users.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chargers.dart';

part 'bookings.g.dart';

@JsonSerializable()
class BookingStatus {
  BookingStatus({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory BookingStatus.fromJson(Map<String, dynamic> json) =>
      _$BookingStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BookingStatusToJson(this);
}

@JsonSerializable()
class Booking {
  Booking({
    this.id,
    required this.user,
    required this.publication,
    required this.start_date,
    required this.end_date,
    required this.status,
    required this.created,
  });

  int? id;
  BasicUser user;
  Publication publication;
  DateTime start_date;
  DateTime end_date;
  BookingStatus status;
  DateTime created;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
