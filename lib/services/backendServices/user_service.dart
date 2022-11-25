import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import '../../serializers/users.dart';
import '../../widgets/alert_dialog.dart';

const String registerUrl = "users/register/";
const String userUrl = 'users/1/';
const String editUrl = 'users/';



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
  static void registerUser(BuildContext context,String username, String email, String password,String firstName,String lastName){
      Map<String,dynamic> registerMap = {
          'email': email,
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName
        };

      BackendService.post(registerUrl,registerMap).then((response) async {
        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          LoginService ls = await LoginService();
          ls.loginUser(jsonResponse['apikey']);
          GoRouter.of(context).push('/');

        }
        else {
          var jsonResponse = jsonDecode(response.body);
          String value = jsonResponse["res"];
          Future.delayed(Duration.zero, () => showAlert(context,"Error Message",value));
      }
    });
  }

  static void editUser(String email, String image_path, String about, String firstName, String lastName,BuildContext context) {
    Map<String, dynamic> editMap = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "about": about
    };
    BackendService.put(editUrl, editMap).then((response) {
      if (response.statusCode == 200) {
        var _loginService = LoginService();
        _loginService.update_user_info();
        GoRouter.of(context).push('/');
      }
      else {
        print('Error with the register!');
      }
    });
  }
}