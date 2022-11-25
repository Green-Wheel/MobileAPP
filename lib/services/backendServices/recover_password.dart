import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';


String get_recover = 'users/password/recovery?username=';
String get_code = 'users/password/recovery/';

class RecoverPasswordService extends ChangeNotifier {

  static Future<bool?> getRecover(String username) async {
      return await BackendService.get(get_recover + username).then((response) {
      if (response.statusCode == 200) {
        return true;
      }
      else {
        return false;
        throw Exception('Error getting user!');
      }
    });
  }

  static void checkCode(String code , String username,BuildContext context)  async {
    Map<String, dynamic> checkCode = {
      "username": username,
      "code": int.parse(code)
    };
    return  await BackendService.put(get_code, checkCode).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        LoginService ls = LoginService();
        ls.loginUser(jsonResponse['apikey']);
        GoRouter.of(context).go('/login/recover_password/change_password');
      }
      else {
        print('Code is not the same!');
      }
    });
  }

}