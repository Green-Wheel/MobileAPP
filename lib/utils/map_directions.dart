import '../serializers/maps.dart';
import '../services/google_service.dart';

class MapDirections {
  static List<String> getDirections(LatLng origin, LatLng destination) {
    List<String> directions = [];
    GoogleService.getDirections(origin, destination).then((response) {
      if (response['status'] == 'OK') {
        final routes = response['routes'];
        final legs = routes[0]['legs'];
        final steps = legs[0]['steps'];
        for (var i = 0; i < steps.length; i++) {
          directions.add(steps[i]['html_instructions']);
        }
      }
    });
    return directions;
  }
}
