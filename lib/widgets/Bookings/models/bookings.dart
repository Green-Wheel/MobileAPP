
import 'dart:convert';

import 'package:greenwheel/widgets/Bookings/models/users.dart';



class Booking {
  Booking({
    required this.id,
    required this.user,
    this.publication,
  });

  int id;
  User user;
  dynamic publication;

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    user: User.fromJson(json["user"]),
    publication: json["publication"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "publication": publication,
  };
}
