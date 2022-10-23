import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/utils/lang_config.dart';

const String baseUrl = "users/language/";

class LocaleLanguage extends ChangeNotifier {
  fetchLocale(BuildContext context) async {
    BackendService.get(baseUrl).then((response) async {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        context.setLocale(
            LangConfig.getLocaleFromString(jsonResponse['language']));
      } else {
        String? device_locale = await Devicelocale.currentLocale;
        device_locale = device_locale!.substring(0, 2);

        if (device_locale != null) {
          context.setLocale(LangConfig.getLocaleFromString(device_locale));
        }
      }
    });
  }
}