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

  static Future<Rating> getRating(int id) async {
    var result = null;
    await BackendService.get('ratings/$id/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = Rating.fromJson(jsonResponse);
      } else {
        print('Error getting rating!');
      }
    });
    return result;
  }
}