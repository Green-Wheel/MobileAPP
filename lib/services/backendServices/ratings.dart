import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/ratings.dart';

class RatingService {
  static List<Rating>? getRatings() {
    List<Rating> ratingList = [];
    BackendService.get('ratings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Rating> ratings = jsonResponse.map((e) => Rating.fromJson(e)).toList();
        ratingList = ratings;
      } else {
        print('Error getting ratings!');
      }
    });
    return ratingList;
  }
}