import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/ratings.dart';

class RatingService {
  static Future<List?> getRatings() async {
    List result = [];
    await BackendService.get('ratings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse;
      } else {
        print('Error getting bookings!');
      }
    });
    return result;
  }
}