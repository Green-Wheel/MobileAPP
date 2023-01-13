import '../serializers/maps.dart';
import '../services/google_service.dart';

class RouteDistance {
  static DistanceMatrix getDistanceMatrix(LatLang origin, LatLang destination) {
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
