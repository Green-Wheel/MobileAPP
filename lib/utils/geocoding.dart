import 'package:geolocator/geolocator.dart';

import '../serializers/maps.dart';
import '../services/google_service.dart';

class Geocoding {
  static Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static LatLang getLatLngFromPosition(Position position) {
    return LatLang(lat: position.latitude, lng: position.longitude);
  }

  static Future<LatLang>? getLatLangFromAddress(String address) async {
    var response = await GoogleService.getGeocoding(address);
    final results = response['results'];
    final geometry = results[0]['geometry'];
    final location = geometry['location'];
    final lat = location['lat'];
    final lng = location['lng'];
    LatLang latLng = LatLang(lat: lat, lng: lng);
    return latLng;
  }

  static Future<Address?> getAddressFromLatLang(LatLang latLng) async {
    var response = await GoogleService.getReverseGeocoding(latLng);
    if (response['status'] == 'OK') {
      final results = response['results'];
      final address_components = results[0]['address_components'];
      Address address = Address(
          street: "",
          streetNumber: "",
          city: "",
          postalCode: "",
          province: "",
          country: "");
      for (var i = 0; i < address_components.length; i++) {
        final types = address_components[i]['types'];
        if (types.contains('street_number')) {
          address.streetNumber = address_components[i]['long_name'];
        }
        if (types.contains('route')) {
          address.street = address_components[i]['long_name'];
        }
        if (types.contains('locality')) {
          address.city = address_components[i]['long_name'];
        }
        if (types.contains('postal_code')) {
          address.postalCode = address_components[i]['long_name'];
        }
        if (types.contains('administrative_area_level_2')) {
          address.province = address_components[i]['long_name'];
        }
        if (types.contains('country')) {
          address.country = address_components[i]['long_name'];
        }
      }
      return address;
    }
    return null;
  }

  static Future<Address>? getCurrentAddress() {
    getCurrentPosition().then((position) async {
      LatLang latLng = getLatLngFromPosition(position);
      return getAddressFromLatLang(latLng);
    });
    return null;
  }
}
