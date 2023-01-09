import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/ratings.dart';
import '../../widgets/alert_dialog.dart';

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

  static Future<List<Rating>> getRatingsUsers(int id) async {
    List<Rating> result = [];
    await BackendService.get('ratings/client/$id').then((response) {
      if (response.statusCode == 200) {
        print(200);
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> ratings = jsonResponse['results'] as List<dynamic>;
        result = ratings.map((e) => Rating.fromJson(e)).toList();
        //result = jsonResponse;
      } else {
        print(response.statusCode);
        print('Error getting ratings!');
      }
    });
    return result;
  }

  static void addRating(int id, int booking_id, String message, double rating, BuildContext context){

    Map<String,dynamic> ratingMap = {
      'booking': booking_id,
      'rate': rating,
      'comment': message
    };

    BackendService.post('ratings/client/$id',ratingMap).then((response)  {
      print(response.statusCode);
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        print("asasas  " +  jsonResponse);
        GoRouter.of(context).push('/');
      }
      else {
        var jsonResponse = jsonDecode(response.body);
        String value = jsonResponse["res"];
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message",value));
      }
    });
  }


}