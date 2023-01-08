import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import '../../helpers/constants.dart';
import '../../serializers/chargers.dart';
import '../../serializers/users.dart';
import '../../widgets/alert_dialog.dart';
import 'package:http/http.dart' as http;

const String registerUrl = "users/register/";
const String editUrl = 'users/';
const String uploadImageUrl = 'users/upload/';

class UserService extends ChangeNotifier {
  static Future<User?> getUser(int id) async {
    User? result;
    var response = await BackendService.get('users/$id/');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      result = User.fromJson(jsonResponse);
    } else {
      throw Exception('Error getting user!');
    }
    return result;
  }

  static Future<List<Publication>> getPostsUser(int id) async {
    List<Publication> result = [];
    await BackendService.get('users/$id/posts').then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> publication = jsonResponse['results'] as List<dynamic>;
        result = publication.map((e) => Publication.fromJson(e)).toList();
      } else {
        print(response.body);
        print('Error getting bookings!');
      }
    });
    return result;
  }

  static Future<String?> loginGoogleUser(GoogleSignInAccount userinfo) async {
    await BackendService.post('users/login/google/', {'userinfo': userinfo})
        .then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse["api_key"];
      } else {
        print("Login error");
      }
    });
    return null;
  }

  static Future<String?> getRacoAuthorizationCode() async {
    final url = Uri.parse(
        "https://api.fib.upc.edu/v2/o/authorize/?client_id=$RACO_CLIENT_ID&redirect_uri=$RACO_REDIRECT_URI&response_type=code&scope=read&state=greenwheel&approval_prompt=auto");
    // Present the dialog to the user
    final result = await FlutterWebAuth2.authenticate(
        url: url.toString(), callbackUrlScheme: "apifib");
    print(result);
// Extract code from resulting url
    final code = Uri.parse(result).queryParameters['code'];
    print(code);
    return code;
  }

  static Future<String?> loginRacoUser(String code) async {
    await BackendService.post('users/login/raco/', {'code': code})
        .then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse["api_key"];
      } else {
        print("Login error");
      }
    });
    return null;
  }

  static void registerUser(BuildContext context, String username, String email,
      String password, String firstName, String lastName) {
    Map<String, dynamic> registerMap = {
      'email': email,
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName
    };

    BackendService.post(registerUrl, registerMap).then((response) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        LoginService ls = LoginService();
        ls.loginUser(jsonResponse['apikey']);
        GoRouter.of(context).push('/');
      } else {
        String x = "Error: duplicate key value violates unique constraint";
        var jsonResponse = jsonDecode(response.body);
        String value = jsonResponse["res"];
        if (response.body.contains(x))
          Future.delayed(
              Duration.zero,
              () => showAlert(
                  context, "Error Message", "Username already exists"));
        else
          Future.delayed(
              Duration.zero, () => showAlert(context, "Error Message", value));
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

  static void postImage(BuildContext context, File file) {
    List<File> image =[];
    image.add(file);
    BackendService.postFiles(uploadImageUrl, image).then((response) {
      if (response.statusCode == 200 ) {
        var _loginService = LoginService();
        _loginService.update_user_info();
        Future.delayed(Duration.zero, () => showAlert(context,"Done","You have changed your image"));
      }
      else {
        Future.delayed(Duration.zero, () => showAlert(context,"Error","We cannot retrieve the image"));
      }
    });
  }
}