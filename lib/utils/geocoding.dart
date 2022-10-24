import 'package:geolocator/geolocator.dart';

import '../serializers/maps.dart';
import '../services/google_service.dart';

class Geocoding {
  static Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static LatLng getLatLngFromPosition(Position position) {
    return LatLng(lat: position.latitude, lng: position.longitude);
  }

  static LatLng? getLatLangFromAddress(String address) {
    GoogleService.getGeocoding(address).then((response) {
      if (response['status'] == 'OK') {
        final results = response['results'];
        final geometry = results[0]['geometry'];
        final location = geometry['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        LatLng latLng = LatLng(lat: lat, lng: lng);
        return latLng;
      }
    });
    return null;
  }

  static Address? getAddressFromLatLang(LatLng latLng) {
    GoogleService.getReverseGeocoding(latLng).then((response) {
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
    });
    return null;
  }

  static Address? getCurrentAddress() {
    getCurrentPosition().then((position) async {
      LatLng latLng = getLatLngFromPosition(position);
      return getAddressFromLatLang(latLng);
    });
    return null;
  }
}
