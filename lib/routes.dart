
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
import 'package:greenwheel/screens/chargers/add_charger.dart';
import 'package:greenwheel/screens/chargers/edit_charger.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/route/route.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(key: Key("HomePage")),
      routes: [
        GoRoute(
          //aun no funciona
          path: 'chargers/add',//'chargers/:id/edit',
          builder: (context, state) {
            //final id = state.params['id'] as int;
            return EditCharger(key: const Key("EditCharger"), id: 2);
          },
        ),
        /*GoRoute(
          path: 'chargers/add',
          builder: (context, state) => const AddCharger(key: Key("EditCharger")),
        ),*/
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
);