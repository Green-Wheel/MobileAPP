import 'package:flutter/material.dart';

class LangConfig {
  static final langs = [
    const Locale('es', 'ES'),
    const Locale('en', 'US'),
    const Locale('ca', 'ES'),
  ];

  static String getFlag(String lang) {
    switch (lang) {
      case 'es':
        return '🇪🇸';
      case 'en':
        return '🇺🇸';
      case 'ca':
        return '🇪🇸';
      default:
        return '🇪🇸';
    }
  }

  static Locale getLocaleFromString(substring) {
    switch (substring) {
      case 'es':
        return const Locale('es', 'ES');
      case 'en':
        return const Locale('en', 'US');
      case 'ca':
        return const Locale('ca', 'ES');
      default:
        return const Locale('es', 'ES');
    }
  }

  static String getStringFromLocale(Locale locale) {
    switch (locale.toString()) {
      case 'es_ES':
        return 'es';
      case 'en_US':
        return 'en';
      case 'ca_ES':
        return 'ca';
      default:
        return 'es';
    }
  }
}
