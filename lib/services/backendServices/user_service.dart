import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import '../../serializers/users.dart';
import '../../widgets/alert_dialog.dart';

const String registerUrl = "users/register/";
const String editUrl = 'users/';
const String uploadImageUrl = 'users/upload/';



class UserService extends ChangeNotifier {

  static void registerUser(BuildContext context,String username, String email, String password,String firstName,String lastName){
      Map<String,dynamic> registerMap = {
          'email': email,
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName
        };

      BackendService.post(registerUrl,registerMap).then((response)  {
        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          LoginService ls =  LoginService();
          ls.loginUser(jsonResponse['apikey']);
          GoRouter.of(context).push('/');

        }
        else {
          String x = "Error: duplicate key value violates unique constraint";
          var jsonResponse = jsonDecode(response.body);
          String value = jsonResponse["res"];
          if(response.body.contains(x)) Future.delayed(Duration.zero, () => showAlert(context,"Error Message","Username already exists"));
          else Future.delayed(Duration.zero, () => showAlert(context,"Error Message",value));
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
      if (response.statusCode == 200 ) {
        var _loginService = LoginService();
        _loginService.update_user_info();
        GoRouter.of(context).push('/');
        Future.delayed(Duration.zero, () => showAlert(context,"Done","You have changed your profile"));
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Suggestion","Set a correct email"));
      }
    });
  }

  static void putImage(BuildContext context, File file) {
    List<File> image =[];
    image.add(file);
    BackendService.postFiles(uploadImageUrl, image).then((response) {
      if (response.statusCode == 200 ) {
        var _loginService = LoginService();
        _loginService.update_user_info();
        Future.delayed(Duration.zero, () => showAlert(context,"Done","You have changed your image"));
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error","We cannot retrieve the iamge"));
      }
    });
  }
}