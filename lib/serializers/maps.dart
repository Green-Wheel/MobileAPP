import 'package:json_annotation/json_annotation.dart';

part 'maps.g.dart';

@JsonSerializable()
class LatLang {
  LatLang({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory LatLang.fromJson(Map<String, dynamic> json) =>
      _$LatLangFromJson(json);

  Map<String, dynamic> toJson() => _$LatLangToJson(this);
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

@JsonSerializable()
class Direction {
  Direction({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.polylinePoints,
  });

  String distance;
  String duration;
  String endAddress;
  LatLang endLocation;
  String startAddress;
  LatLang startLocation;
  List<Steps> steps;
  List<LatLang> polylinePoints;

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      distance: json['routes'][0]['legs'][0]['distance']['text'],
      duration: json['routes'][0]['legs'][0]['duration']['text'],
      endAddress: json['routes'][0]['legs'][0]['end_address'],
      endLocation: LatLang(
          lat: json['routes'][0]['legs'][0]['end_location']['lat'],
          lng: json['routes'][0]['legs'][0]['end_location']['lng']),
      startAddress: json['routes'][0]['legs'][0]['start_address'],
      startLocation: LatLang(
          lat: json['routes'][0]['legs'][0]['start_location']['lat'],
          lng: json['routes'][0]['legs'][0]['start_location']['lng']),
      steps: (json['routes'][0]['legs'][0]['steps'] as List)
          .map((e) => Steps.fromJson(e))
          .toList(),
      polylinePoints: PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points'])
          .map((e) => LatLang(lat: e.latitude, lng: e.longitude))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$DirectionToJson(this);
}

class PolylinePoints {
  List<PointLatLng> decodePolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      PointLatLng p =
          PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }

    return poly;
  }
}

class PointLatLng {
  double latitude;
  double longitude;

  PointLatLng(this.latitude, this.longitude);
}

@JsonSerializable()
class Steps {
  Steps({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    //required this.polyline,
    required this.startLocation,
    required this.travelMode,
  });

  String distance;
  String duration;
  LatLang endLocation;
  String htmlInstructions;

  //Polyline polyline;
  LatLang startLocation;
  String travelMode;

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      distance: json['distance']['text'],
      duration: json['duration']['text'],
      endLocation: LatLang.fromJson(json['end_location']),
      htmlInstructions: json['html_instructions'],
      //polyline: ,
      startLocation: LatLang.fromJson(json['start_location']),
      travelMode: json['travel_mode'],
    );
  }

  Map<String, dynamic> toJson() => _$StepsToJson(this);
}