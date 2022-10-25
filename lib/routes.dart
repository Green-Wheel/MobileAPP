import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/route/route.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(key: Key("HomePage")),
    ),
    GoRoute(
      path: '/route/:lat/:long',
      builder: (context, state) {
        final long = state.params['long']!;
        final lat = state.params['lat']!;
        return RoutePage(
          key: Key("RoutePage"),
          lat: lat,
          long: long,
        );
      },
    ),
  ],
);
