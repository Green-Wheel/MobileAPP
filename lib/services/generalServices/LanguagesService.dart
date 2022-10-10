import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/services/backend_service.dart';

import '../../languages/lang_config.dart';

const String baseUrl = "users/language/";

class LocaleLanguage extends ChangeNotifier {
  static Locale _locale = LangConfig.getLocale('es');

  Locale get locale => _locale;

  fetchLocale() async {
    BackendService.get(baseUrl).then((response) async {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        changeLanguage(LangConfig.getLocale(jsonResponse['language']));
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
    var jsonMap = {'language': LangConfig.getStringFromLocale(locale)};
    BackendService.put(baseUrl, jsonMap)
        .then((value) => null)
        .catchError((error) => print(error));
  }
  void clearLocale() {
    _locale = LangConfig.getLocale('es');
    notifyListeners();
  }
}