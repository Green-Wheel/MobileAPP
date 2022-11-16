import 'package:greenwheel/serializers/users.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chargers.dart';

part 'bookings.g.dart';

@JsonSerializable()
class Booking {
  Booking({
    this.id,
    required this.user,
    required this.publication,
    required this.start_date,
    required this.end_date,
    required this.confirmed,
    required this.finished,
    required this.cancelled,
    required this.created,
  });

  int? id;
  User user;
  Publication publication;
  DateTime start_date;
  DateTime end_date;
  bool confirmed;
  bool finished;
  bool cancelled;
  DateTime created;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable()
class Bookings {
  Bookings({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Booking> results;

  factory Bookings.fromJson(Map<String, dynamic> json) =>
      _$BookingsFromJson(json);

  Map<String, dynamic> toJson() => _$BookingsToJson(this);
}
