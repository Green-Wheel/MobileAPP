import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/users.dart';

const String baseUrl = "users/register/";

class UserService extends ChangeNotifier {

  static User? getUser() {
    User? user;
    BackendService.get('users/3/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        user = User.fromJson(jsonResponse);
        print(user?.id);
        return user;
      } else {
        print('Error getting user!');
      }
    });
    return user;
  }

  static void registerUser(String username, String email, String password){
      Map<String,dynamic> registerMap = {
        'user': {
          'username': username,
          'email': email,
          'password': password,
        }
      };

      BackendService.post(baseUrl,registerMap).then((response) {
      if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse);

          //Map<String, dynamic> map = json.decode(response.body);
          //print(map[0]['created']);
          // List<dynamic> list = map.toList();
          // List<dynamic> data = map["id"];
          // print(data[0]["id"]);
        } else {
          print('Error with the register!');
        }
      });
  }
}