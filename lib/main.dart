import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:greenwheel/routes.dart';
import 'package:greenwheel/services/generalServices/LanguagesService.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/theme/style.dart';
import 'package:greenwheel/utils/lang_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: LangConfig.langs,
        path: 'langs', // <-- change the path of the translation files
        fallbackLocale: const Locale('es', 'ES'),
        child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _loggedInStateInfo = LoginService();
  LocaleLanguage localeLanguage = LocaleLanguage();

  late final _router = routeGenerator(_loggedInStateInfo);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    localeLanguage.fetchLocale(context);
    _loggedInStateInfo.checkLoggedIn();
    return MaterialApp.router(
      title: 'GreenWheel',
      theme: appTheme(),
      routerConfig: _router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
