import '../serializers/maps.dart';
import '../services/google_service.dart';

class MapDirections {
  static Future<Direction> getDirections(
      LatLang origin, LatLang destination) async {
    var response = await GoogleService.getDirections(origin, destination);
    if (response['status'] == 'OK') {
      print("OK");
      return Direction.fromJson(response);
    } else {
      throw Exception('Failed to load directions');
    }
  }
}
