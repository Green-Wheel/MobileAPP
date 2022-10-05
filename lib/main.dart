import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:greenwheel/routes.dart';
import 'package:greenwheel/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenWheel',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
