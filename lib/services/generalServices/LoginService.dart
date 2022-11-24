import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../backend_service.dart';

class LoginService extends ChangeNotifier {
  static var _loggedIn = false;
  FlutterSecureStorage storage = FlutterSecureStorage();

  bool get isLoggedIn => _loggedIn;
  static var _apiKey = null;
  static var _user_info = null;

  String? get apiKey => _apiKey;

  Map<String, dynamic>? get user_info => _user_info;

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
          "profile_picture": jsonResponse["profile_picture"],
          "level": jsonResponse["level"],
          "xp": jsonResponse["xp"],
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
}
