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

  static Future<List?> getRatingsUsers(int id) async {
    List result = [];
    await BackendService.get('client/$id').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse;
      } else {
        print('Error getting ratings!');
      }
    });
    return result;
  }

  static void addRating(int id_booking, String message, double rating){
    /*
    Map<String,dynamic> registerMap = {
      'email': email,
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName
    };

    BackendService.post(registerUrl,registerMap).then((response)  {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        LoginService ls =  LoginService();
        ls.loginUser(jsonResponse['apikey']);
        GoRouter.of(context).push('/');
      }
      else {
        String x = "Error: duplicate key value violates unique constraint";
        var jsonResponse = jsonDecode(response.body);
        String value = jsonResponse["res"];
        if(response.body.contains(x)) Future.delayed(Duration.zero, () => showAlert(context,"Error Message","Username already exists"));
        else Future.delayed(Duration.zero, () => showAlert(context,"Error Message",value));
      }
    });

     */
  }


}