import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

import '../../languages/lang_config.dart';

final String baseUrl = FlutterConfig.get('BACKEND_API_URL') + "users/";

class LocaleLanguage extends ChangeNotifier {
  static Locale _locale = LangConfig.getLocale('es');

  Locale get locale => _locale;

  fetchLocale() async {
    getUserLanguage().then((locale) async {
      if (locale != null) {
        changeLanguage(LangConfig.getLocale(locale));
      } else {
        String? device_locale = await Devicelocale.currentLocale;
        device_locale = device_locale!.substring(0, 2);

        if (device_locale != null) {
          changeLanguage(LangConfig.getLocale(device_locale));
        }
      }
    });
  }

  void changeLanguage(Locale locale) {
    if (!LangConfig.langs.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
    setUserLanguage(LangConfig.getStringFromLocale(locale));
  }

  void clearLocale() {
    _locale = LangConfig.getLocale('es');
    notifyListeners();
  }
}

Future<String> getUserLanguage() async {
  http.Response response = await http.get(
    Uri.parse("${baseUrl}languages/"),
    headers: {"Accept": "application/json"},
  );
  print("Response ${response.body.toString()}");
  return response.body;
}

Future<String> setUserLanguage(String lang) async {
  var jsonMap = {
    "language": lang,
  };
  http.Response response = await http.put(
    Uri.parse("${baseUrl}languages/"),
    headers: {"Accept": "application/json"},
    body: jsonEncode(jsonMap),
  );
  print("Response ${response.body.toString()}");
  return response.body;
}