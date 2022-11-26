import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';

import '../../widgets/alert_dialog.dart';


String reset_password = 'users/password/change/';

class ChangePasswordService extends ChangeNotifier {

  static void checkPassword(String password,BuildContext context)  async {
    Map<String, dynamic> checkPassword = {
      "password": password,
    };
    return await BackendService.put(reset_password, checkPassword).then((response) {
      if (response.statusCode == 200) {
        GoRouter.of(context).push('/login');
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error Message","Not the same password or password has to include on of these chracter \$@#- 6 characters-1 number- UpperCase "));
      }
    });
  }
}