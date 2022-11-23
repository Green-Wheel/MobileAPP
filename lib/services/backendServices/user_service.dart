import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/users.dart';

const String registerUrl = "users/register/";
const String userUrl = 'users/1/';

class UserService extends ChangeNotifier {

  static Future<User>? getUser() {
    User user;
    return BackendService.get(userUrl).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        user = User.fromJson(jsonResponse);
        return user;
      }
      else {
        return throw Exception('Error getting user!');
      }
    });
  }
  static void registerUser(String username, String email, String password,String firstName,String lastName){
    Map<String,dynamic> registerMap = {
        'email': email,
        'username': username,
        'password': password,
        'first_name': firstName,
        'last_name': lastName
      };

    BackendService.post(registerUrl,registerMap).then((response) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      }
      else if(response.statusCode == 400){
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      }
      else {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print('Error with the register!');
      }
    });
  }

}