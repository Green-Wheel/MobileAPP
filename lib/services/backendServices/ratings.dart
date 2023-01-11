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
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> ratings = jsonResponse['results'] as List<dynamic>;
        result = ratings.map((e) => Rating.fromJson(e)).toList();
      } else {
        print('Error getting ratings!');
      }
    });
    return result;
  }

  static Future<List<Rating>> getRatingsPublication(int publication_id) async {
    List<Rating> result = [];
    await BackendService.get('ratings/publication/$publication_id').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> ratings = jsonResponse['results'] as List<dynamic>;
        result = ratings.map((e) => Rating.fromJson(e)).toList();
      } else {
        print('Error getting ratings!');
      }
    });
    return result;
  }

  static void addUserRating(int user_id, int? booking_id, String message, double rating, BuildContext context){
    Map<String,dynamic> ratingMap = {
      'booking': booking_id,
      'rate': rating,
      'comment': message
    };

    BackendService.post('ratings/client/$user_id/',ratingMap).then((response)  {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        GoRouter.of(context).push('/');
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message",response.body));
      }
    });
  }

  static void addBookingRating(int booking_id, int publication_id, String message, double rating, BuildContext context){

    Map<String,dynamic> ratingMap = {
      'booking': booking_id,
      'rate': rating,
      'comment': message
    };

    BackendService.post('ratings/publication/$publication_id/',ratingMap).then((response)  {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        GoRouter.of(context).push('/');
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message",response.body));
      }
    });
  }


}