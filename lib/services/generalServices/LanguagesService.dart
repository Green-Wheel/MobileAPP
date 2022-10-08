import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';

import '../../languages/lang_config.dart';

class LocaleLanguage extends ChangeNotifier {
  static Locale _locale = LangConfig.getLocale('es');

  Locale get locale => _locale;

  fetchLocale() async {
    String? device_locale = await Devicelocale.currentLocale;
    device_locale = device_locale!.substring(0, 2);

    if (device_locale != null) {
      changeLanguage(LangConfig.getLocale(device_locale));
    }
  }

  void changeLanguage(Locale locale) {
    if (!LangConfig.langs.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = LangConfig.getLocale('es');
    notifyListeners();
  }
}
