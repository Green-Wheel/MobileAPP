import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenwheel/helpers/constants.dart';
import 'package:greenwheel/services/backendServices/user_service.dart';

import '../../serializers/users.dart';
import '../backend_service.dart';

class LoginService extends ChangeNotifier {
  static final LoginService instance = LoginService._();

  factory LoginService() => instance;

  LoginService._();

  static var _loggedIn = false;
  FlutterSecureStorage storage = FlutterSecureStorage();

  bool get isLoggedIn => _loggedIn;
  static var _apiKey = null;
  static var _user_info = null;

  String? get apiKey => _apiKey;

  Map<String, dynamic>? get user_info => _user_info;
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  static final _googleSignIn = GoogleSignIn();

  checkLoggedIn() async {
    //storage.delete(key: "apiKey");
    var key = await storage.read(key: "apiKey");
    if (key != null) loginUser(key);
  }

  loginUser(String apiKey_key) {
    _apiKey = apiKey_key;
    _loggedIn = true;
    storage.write(key: "apiKey", value: apiKey_key);
    notifyListeners();
    update_user_info();
  }

  update_user_info() {
    BackendService.get('users/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _user_info = {
          "id": jsonResponse["id"],
          "username": jsonResponse["username"],
          "first_name": jsonResponse["first_name"],
          "last_name": jsonResponse["last_name"],
          "about": jsonResponse["about"],
          "email": jsonResponse["email"],
          "profile_picture": jsonResponse["profile_picture"],
          "level": jsonResponse["level"],
          "xp": jsonResponse["xp"],
          "rating": jsonResponse["rating"],
          "selected_car": jsonResponse["selected_car"],
        };
      }
    });
  }

  logout() {
    _apiKey = null;
    _loggedIn = false;
    storage.delete(key: "apiKey");
    _user_info = null;
    notifyListeners();
  }

  Future google_login() async {
    print("google login");
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final data = {
        "id": googleUser.id,
        "email": googleUser.email,
        "displayName": googleUser.displayName,
        "photoUrl": googleUser.photoUrl,
      };
      final String apiKey_key = await UserService.loginGoogleUser(data);
      if (apiKey_key != '') {
        _apiKey = apiKey_key;
        _loggedIn = true;
        storage.write(key: "apiKey", value: apiKey_key);
        notifyListeners();
        await update_user_info();
        return true;
      }
      print("error login google");
    }
    return false;
  }

  Future raco_login() async {
    final code = await UserService.getRacoAuthorizationCode();
    if (code != null) {
      final String? apiKey_key = await UserService.loginRacoUser(code);
      if (apiKey_key != null && apiKey_key != '') {
        _apiKey = apiKey_key;
        _loggedIn = true;
        storage.write(key: "apiKey", value: apiKey_key);
        notifyListeners();
        await update_user_info();
        return true;
      }
      print("error login google");
    }
    return false;
  }
}
