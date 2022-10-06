import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LangConfig {
  static final langs = [
    const Locale('es', 'ES'),
    const Locale('en', 'US'),
    const Locale('ca', 'ES'),
  ];

  static final delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
