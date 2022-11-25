import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';


String reset_password = 'users/password/change/';

class ChangePasswordService extends ChangeNotifier {

  static void checkPassword(String password,BuildContext context)  async {
    Map<String, dynamic> checkPassword = {
      "password": password,
    };
    return  await BackendService.put(reset_password, checkPassword).then((response) {
      if (response.statusCode == 200) {
        GoRouter.of(context).push('/login');
      }
      else {
        print("Miauuuuuuuuuuuuuu");
        print('Code is not the same!');
      }
    });
  }
}