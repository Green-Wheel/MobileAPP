import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'LoginService.dart';

class NotificationService {
  static final NotificationService _singleton = NotificationService._internal();

  factory NotificationService() => _singleton;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late InitializationSettings initializationSettings;

  IOWebSocketChannel? channel;
  late var channelStream = channel?.stream.asBroadcastStream();

  //final _loggedInStateInfo = LoginService();

  NotificationService._internal() {
    initWebSocketConnection();
  }

  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    print('initialize');
    var androidInitialize = const AndroidInitializationSettings('@mipmap/greenwheelfonsblanc');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('initialize done');
  }

  initWebSocketConnection() async {
    print("Connecting...");
    //var data = _loggedInStateInfo.user_info;
    try {
      //print(data!['id']);
      //int userId = LoginService().user_info!['id'];
      //print('user id -> $userId');
      channel = IOWebSocketChannel.connect(
        //Uri.parse('ws://3.250.219.80/ws/2/notifications/'),
        Uri.parse('ws://3.250.219.80/ws/3/notifications/'),
        pingInterval: const Duration(seconds: 10),
      );
      print('Connected');
      channelStream?.listen((message) {
        print(message);
        // Show notification when message is received
        final notification = json.decode(message);
        final title = notification['title'];
        final body = notification['body'];
        showNotification(
            title: title, body: body, fln: flutterLocalNotificationsPlugin);
      });
    } on Exception catch (e) {
      print(e);
      return await initWebSocketConnection();
    }

    print("Socket connected");
    channel?.sink.done.then((dynamic _) => _onDisconnected());
  }

  void _onDisconnected() {
    print("Socket disconnected");
    initWebSocketConnection();
  }

  static Future showNotification({var id = 0, required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        icon: '@mipmap/greenwheelfonsblanc',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
  }
}
