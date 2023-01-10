import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:greenwheel/routes.dart';
import 'package:greenwheel/services/generalServices/LanguagesService.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/theme/style.dart';
import 'package:greenwheel/utils/lang_config.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await EasyLocalization.ensureInitialized();

  initializeWebSocket();

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
    initializeWebSocket();
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          title: 'GreenWheel',
          theme: appTheme(),
          routerConfig: _router,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        ));
  }
}

void initializeWebSocket() {
  TextEditingController _message;
  WebSocketChannel channel;
  bool _iserror = false;
  var sub;
  String title;
  String body;
  print("Initializing websocket");
  FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
  var androidInit = const AndroidInitializationSettings('@mipmap/greenwheelfonsblanc');
  var iOSInit = const DarwinInitializationSettings();
  //int userId = LoginService().user_info?['id'];
  channel = IOWebSocketChannel.connect('ws://3.250.219.80/ws/3/notifications/');
  _message = TextEditingController();
  var init = InitializationSettings(android: androidInit, iOS: iOSInit);
  notifications.initialize(init).then((done) {
    sub = channel.stream.listen((newData) {
      title = json.decode(newData)['title'];
      body = json.decode(newData)['body'];
      notifications.show(
          0,
          title,
          body,
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'channel_id',
                  'channel_name',
                  icon: '@mipmap/greenwheelfonsblanc',
                  importance: Importance.max,
                  priority: Priority.high,
                  ticker: 'ticker'
              ),
              iOS: DarwinNotificationDetails()));
    });
  });
}