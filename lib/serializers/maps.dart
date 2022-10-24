import 'package:json_annotation/json_annotation.dart';

part 'maps.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

@JsonSerializable()
class DistanceMatrix {
  DistanceMatrix({
    required this.distance,
    required this.duration,
  });

  String distance;
  String duration;

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) =>
      _$DistanceMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceMatrixToJson(this);
}

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.streetNumber,
    required this.city,
    required this.postalCode,
    required this.province,
    required this.country,
  });

  String street;
  String streetNumber;
  String city;
  String postalCode;
  String province;
  String country;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}