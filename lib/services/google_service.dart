import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

import '../serializers/maps.dart';

class GoogleService {
  // https://developers.google.com/maps/documentation/distance-matrix/distance-matrix
  static Future<dynamic> getDistanceMatrix(
      LatLang origin, LatLang destination) async {
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${origin.lat},${origin.lng}&destinations=${destination.lat},${destination.lng}&key=${FlutterConfig.get('GOOGLE_MAPS_API_KEY')}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load distance matrix');
    }
  }

  // https://developers.google.com/maps/documentation/directions/get-directions
  static Future<dynamic> getDirections(
      LatLang origin, LatLang destination, String? lang) async {
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?destination=${destination.lat},${destination.lng}&origin=${origin.lat},${origin.lng}&language=$lang&key=${FlutterConfig.get('GOOGLE_MAPS_API_KEY')}';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  // https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding
  static Future<dynamic> getReverseGeocoding(LatLang latLng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.lat},${latLng.lng}&key=${FlutterConfig.get('GOOGLE_MAPS_API_KEY')}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load geocoding');
    }
  }

  // https://developers.google.com/maps/documentation/geocoding/requests-geocoding
  static Future<dynamic> getGeocoding(String address) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=${FlutterConfig.get('GOOGLE_MAPS_API_KEY')}';
    var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load reverse geocoding');
      }
  }

  // https://developers.google.com/maps/documentation/places/web-service/autocomplete
  static Future<dynamic> getAutocomplete(String input) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&key=${FlutterConfig
        .get('GOOGLE_MAPS_API_KEY')}&components=country:es';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
