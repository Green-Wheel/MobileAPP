import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService extends ChangeNotifier {
  var _loggedIn = false;

  bool get isLoggedIn => _loggedIn;
  var _apiKey = null;

  String get apiKey => _apiKey;

  checkLoggedIn() async {
    const storage = FlutterSecureStorage();
    var key = await storage.read(key: "apiKey");
    print(key);
    if (key != null) loginUser(key);
  }

  loginUser(String apiKey) {
    _apiKey = apiKey;
    _loggedIn = true;
    notifyListeners();
  }

  logout() {
    _apiKey = null;
    _loggedIn = false;
    notifyListeners();
  }
}
