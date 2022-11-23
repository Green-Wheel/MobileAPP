
/*import 'package:flutter/widgets.dart';
import 'package:greenwheel/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const HomePage(key: Key("HomePage")),
  "/addCharger": (BuildContext context) => charger(),
};
*/

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/bookings/bookings.dart';
import 'package:greenwheel/screens/charger-info-list/chargeInfoList.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/login/login_screen.dart';
import 'package:greenwheel/screens/route/route.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/addCharger/add_charger.dart';

GoRouter routeGenerator(LoginService loginService) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: loginService,
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(key: Key("HomePage")),
          routes: [
            GoRoute(
              path: 'chargers/add',
              builder: (context, state) =>
                  const AddCharger(key: Key("AddCharger")),
            ),
            GoRoute(
              path: 'chargers/list',
              builder: (context, state) =>
                  const ChargeInfoList(key: Key("ChargersList")),
            ),
            GoRoute(
              path: 'booking',
              builder: (context, state) =>
                  const MyBookings(key: Key("Booking")),
            ),
            GoRoute(
              path: 'route/:lat/:long',
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
          ]),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(key: Key("LoginPage")),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      if (!loginService.isLoggedIn &&
          state.subloc != '/login' &&
          state.subloc != '/register') {
        return '/login';
      } else {
        return null;
      }
    },
  );
}

/*final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(key: Key("HomePage")),
      routes: [
        GoRoute(
          path: 'chargers/add',
          builder: (context, state) => const AddCharger(key: Key("AddCharger")),
        ),
        GoRoute(
          path: 'chargers/list',
          builder: (context, state) =>
          const ChargeInfoList(key: Key("ChargersList")),
        ),
        GoRoute(
          path: 'booking',
          builder: (context, state) => const MyBookings(key: Key("Booking")),
        ),
        GoRoute(
          path: 'route/:lat/:long',
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
      ]
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {

    String? value = await storage.read(key: "apiKey");
    if (value == null) {
        return '/login';
        } else {
        return null;
        }
  },
); */
