import '../services/google_service.dart';
import '../services/serializers/maps.dart';

class RouteDistance {
  static DistanceMatrix getDistanceMatrix(LatLng origin, LatLng destination) {
    GoogleService.getDistanceMatrix(origin, destination).then((value) {
      print(value);
      if (value['status'] == 'OK') {
        var distance = value['rows'][0]['elements'][0]['distance']['text'];
        var duration = value['rows'][0]['elements'][0]['duration']['text'];
        return DistanceMatrix(distance: distance, duration: duration);
      } else {
        return DistanceMatrix(distance: '-1', duration: '-1');
      }
    });
    return DistanceMatrix(distance: '-2', duration: '-2');
  }
}
