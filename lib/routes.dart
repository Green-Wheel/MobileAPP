import 'package:flutter/widgets.dart';
import 'package:greenwheel/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(key: const Key("HomePage")),
  // "/ExScreen2": (BuildContext context) => ExScreen2(),
};
