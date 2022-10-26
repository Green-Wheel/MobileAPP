import 'package:json_annotation/json_annotation.dart';

part 'bookings.g.dart';

@JsonSerializable()
class Booking {
  Booking({
    this.id,
    required this.userId,
    required this.publicationId,
    required this.startDate,
    required this.endDate,
    required this.confirmed,
    required this.finished,
    required this.canceled,
    required this.createdAt,
  });

  int? id;
  int userId;
  int publicationId;
  DateTime startDate;
  DateTime endDate;
  bool confirmed;
  bool finished;
  bool canceled;
  DateTime createdAt;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
