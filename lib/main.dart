import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:greenwheel/routes.dart';
import 'package:greenwheel/services/generalServices/LanguagesService.dart';
import 'package:greenwheel/theme/style.dart';
import 'package:provider/provider.dart';

import 'languages/lang_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MainApp());
  LocaleLanguage localeLanguage = LocaleLanguage();
  await localeLanguage.fetchLocale();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleLanguage(),
        builder: (context, child) {
          final provider = Provider.of<LocaleLanguage>(context);
          return MaterialApp(
            title: 'GreenWheel',
            theme: appTheme(),
            initialRoute: '/',
            routes: routes,
            locale: provider.locale,
            supportedLocales: LangConfig.langs,
            localizationsDelegates: LangConfig.delegates,
          );
        },
      );
}
