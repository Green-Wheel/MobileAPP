import 'package:flutter/widgets.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/user/chargers/add_charger.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const HomePage(key: Key("HomePage")),
  "/addCharger": (BuildContext context) => charger(),
};
