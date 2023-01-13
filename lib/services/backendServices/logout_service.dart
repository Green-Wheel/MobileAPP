import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import '../../serializers/users.dart';
// LogoutService.logOutUser(context);
const String log_out_url = "users/logout/";

class LogoutService extends ChangeNotifier {
  static Future<bool> logOutUser(BuildContext context) async {
    bool result = false;
    await BackendService.post(log_out_url, {}).then((response) async {
      if (response.statusCode == 200) {
        await LoginService.instance.logout();
        result = true;
      } else {
        var jsonResponse = jsonDecode(response.body);
        print('Error with the logout!');
      }
    });
    return result;
  }
}

