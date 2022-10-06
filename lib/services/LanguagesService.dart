import 'package:flutter/material.dart';

import '../languages/lang_config.dart';

class LocaleLanguage extends ChangeNotifier {
  Locale _locale = const Locale('es', 'ES');

  Locale get locale => _locale;

  void changeLanguage(Locale locale) {
    if (!LangConfig.langs.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('es', 'ES');
    notifyListeners();
  }
}
