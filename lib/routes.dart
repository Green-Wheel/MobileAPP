import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/bike-info-list/bikeInfoList.dart';
import 'package:greenwheel/screens/bike/add_bike.dart';
import 'package:greenwheel/screens/bike/edit_bike.dart';
import 'package:greenwheel/screens/bike/report_bike.dart';
import 'package:greenwheel/screens/bookings/bookings.dart';
import 'package:greenwheel/screens/charger-info-list/chargeInfoList.dart';
import 'package:greenwheel/screens/chargers/add_charger.dart';
import 'package:greenwheel/screens/chargers/edit_charger.dart';
import 'package:greenwheel/screens/chargers/report_charger.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/login/login_screen.dart';
import 'package:greenwheel/screens/profile/editprofile.dart';
import 'package:greenwheel/screens/profile/myprofile.dart';
import 'package:greenwheel/screens/profile/report_comment.dart';
import 'package:greenwheel/screens/profile/report_user.dart';
import 'package:greenwheel/screens/register/change_password.dart';
import 'package:greenwheel/screens/register/recover_password.dart';
import 'package:greenwheel/screens/register/signup.dart';
import 'package:greenwheel/screens/route/route.dart';
import 'package:greenwheel/screens/vehicles/AddVehicleScreen.dart';
import 'package:greenwheel/screens/vehicles/EditVehicleScreen.dart';
import 'package:greenwheel/screens/vehicles/vehicles.dart';
import 'package:greenwheel/screens/trophies/trophiesScreen.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/language_selector_widget.dart';

GoRouter routeGenerator(LoginService loginService) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: loginService,
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) =>  HomePage(key: const Key("HomePage")),
          routes: [
            GoRoute(
                path: 'profile/:id',
                builder: (context, state) {
                  final int id = int.parse(state.params['id']!);
                  return ProfilePage(key: Key("ProfilePage"), id: id);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) =>
                    EditProfile(key: Key("EditProfile")),
                  ),
                  GoRoute(
                    path: 'trophies',
                    builder: (context, state) {
                      final int id = int.parse(state.params['id']!);
                      return TrophiesScreen(key: Key("Trophies"), id);
                    }
                  ),
                ]
            ),
            GoRoute(
              path: 'language',
              builder: (context, state) => const LanguageSelectorWidget(key: Key("Language")),
            ),
            GoRoute(
              path: 'home',
              builder: (context, state) => HomePage(key: const Key("HomePage")),
            ),
            GoRoute(
              path: 'vehicles/add',
              builder: (context, state) =>
              const AddVehicle(key: Key("AddVehicle")),
            ),
            GoRoute(
              path: 'vehicle/edit/:id',
              builder: (context, state) {
                final int id = int.parse(state.params['id']!);
                return EditVehicle(id: id, key: const Key("EditVehicle"));
              },
            ),
            GoRoute(
              path: 'chargers/add',
              builder: (context, state) =>
              const AddCharger(key: Key("AddCharger")),
            ),
            GoRoute(
              path: 'charger/edit/:id',
              builder: (context, state) {
                final int id = int.parse(state.params['id']!);
                return EditCharger(key: const Key("AddBike"), id: id);
              },
            ),
            GoRoute(
              path: 'bikes/add',
              builder: (context, state) => const AddBike(key: Key("AddBike")),
            ),
            GoRoute(
              path: 'bikes/edit/:id',
              builder: (context, state) {
                final int id = int.parse(state.params['id']!);
                return EditBike(key: const Key("AddBike"), id: id);
              },
            ),
            GoRoute(
              path: 'chargers/list',
              builder: (context, state) =>
              const ChargeInfoList(key: Key("ChargersList")),
            ),
            GoRoute(
              path: 'bikes/list',
              builder: (context, state) =>
              const BikeInfoList(key: Key("BikesList")),
            ),
            GoRoute(
              path: 'chargers/:id',
              builder: (context, state) {
                final id = int.parse(state.params['id']!);
                return HomePage(key: const Key("HomePage"), publicationId: id, index: 0);
              },
            ),
            GoRoute(
              path: 'bikes/:id',
              builder: (context, state) {
                final id = int.parse(state.params['id']!);
                return HomePage(key: const Key("HomePage"), publicationId: id, index: 1);
              },
            ),
            GoRoute(
              path: 'booking',
              builder: (context, state) =>
              const MyBookings(key: Key("Booking")),
            ),
            GoRoute(
              path: 'vehicle',
              builder: (context, state) =>
              const MyVehicles(key: Key("Vehicle")),
            ),
            GoRoute(
              path: 'route/:lat/:long/:id',
              builder: (context, state) {
                final long = state.params['long']!;
                final lat = state.params['lat']!;
                final id = int.parse(state.params['id']!);
                return RoutePage(
                  key: const Key("RoutePage"),
                  lat: lat,
                  long: long,
                  pubication_id: id,
                );
              },
            ),
          ]),
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(key: Key("LoginPage")),
          routes: [
            GoRoute(
              path: 'register',
              builder: (context, state) =>
              const SignUpScreen(key: Key("SignUpPage")),
            ),
            GoRoute(
                path: 'recover_password',
                builder: (context, state) =>
                const ForgotPasswordScreen(
                    key: Key("ForgotPasswordScreen")),
                routes: [
                  GoRoute(
                    path: 'change_password',
                    builder: (context, state) =>
                    const ChangePassword(key: Key("ChangePassword")),
                  ),
                ]),
          ]),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      if (!loginService.isLoggedIn &&
          state.subloc != '/login' &&
          state.subloc != '/login/register' &&
          state.subloc != '/login/recover_password' &&
          state.subloc != '/login/recover_password/change_password') {
        return '/login';
      } else {
        return null;
      }
    },
  );
}

