import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/users.dart';

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

}