import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import '../../serializers/users.dart';

String get_recover = 'users/password/recovery?username=';

class RecoverPassword extends ChangeNotifier {

  static Future<bool>? getRecover(String username) {

    print(get_recover + username);
      BackendService.get(get_recover + username).then((response) {
      if (response.statusCode == 200) {
        print("Correct");
        return true;
      }
      else {
        print("Error getting user");
        print(response.statusCode);
        return false;
        throw Exception('Error getting user!');
      }
    });
  }

  static Future<bool>? checkCode(String code) {
    Map<String, dynamic> checkCode = {
      "code": code
    };
    BackendService.put(get_recover, checkCode).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return true;
        print(jsonResponse);
      }
      else {
        return false;
        print('Code is not the same!');
      }
    });
  }

}