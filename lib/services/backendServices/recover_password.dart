import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';

import '../../widgets/alert_dialog.dart';


String get_recover = 'users/password/recovery?username=';
String get_code = 'users/password/recovery/';

class RecoverPasswordService extends ChangeNotifier {

  static Future<bool?> getRecover(String username,BuildContext context) async {
      return await BackendService.get(get_recover + username).then((response) {
      if (response.statusCode == 200) {
        Future.delayed(Duration.zero, () => showAlert(context,"Successful","Correct"));
        return true;
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message","Username doesn't exist"));
        return false;
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
        GoRouter.of(context).push('/login/recover_password/change_password');
      }
      else {
        var jsonResponse = jsonDecode(response.body);
        String value = jsonResponse["res"];
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message",value));
      }
    });
  }

}