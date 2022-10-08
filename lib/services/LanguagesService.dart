import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../languages/lang_config.dart';

class LocaleLanguage extends ChangeNotifier {
  Locale _locale = LangConfig.getLocale(Platform.localeName.substring(3, 5));

  Locale get locale => _locale;

  void changeLanguage(Locale locale) {
    if (!LangConfig.langs.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = LangConfig.getLocale(Platform.localeName.substring(3, 5));
    notifyListeners();
  }
}
