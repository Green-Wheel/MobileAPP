import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/ratings.dart';

class RatingService {
  static Future<List?> getRatings() async {
    await BackendService.get('ratings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        //final ratings = Rating.fromJson(jsonResponse);
        //List<Rating> ratings = jsonResponse.map((e) => Rating.fromJson(e)).toList();
        return jsonResponse;
      } else {
        print('Error getting ratings!');
      }
    });
    return null;
  }

}