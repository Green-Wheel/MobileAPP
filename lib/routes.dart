import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/bike-info-list/bikeInfoList.dart';
import 'package:greenwheel/screens/bike/add_bike.dart';
import 'package:greenwheel/screens/bike/edit_bike.dart';
import 'package:greenwheel/screens/bike/report_bike.dart';
import 'package:greenwheel/screens/bookings/bookings.dart';
import 'package:greenwheel/screens/bookings/reservations.dart';
import 'package:greenwheel/screens/charger-info-list/chargeInfoList.dart';
import 'package:greenwheel/screens/chargers/add_charger.dart';
import 'package:greenwheel/screens/chargers/edit_charger.dart';
import 'package:greenwheel/screens/chat/chat_list_users.dart';
import 'package:greenwheel/screens/chat/chat_view.dart';
import 'package:greenwheel/screens/chargers/report_charger.dart';
import 'package:greenwheel/screens/home/home.dart';
import 'package:greenwheel/screens/login/login_screen.dart';
import 'package:greenwheel/screens/profile/editprofile.dart';
import 'package:greenwheel/screens/profile/myprofile.dart';
import 'package:greenwheel/screens/profile/report_comment.dart';
import 'package:greenwheel/screens/profile/report_user.dart';
import 'package:greenwheel/screens/rating/user_rating_valoration.dart';
import 'package:greenwheel/screens/register/change_password.dart';
import 'package:greenwheel/screens/register/recover_password.dart';
import 'package:greenwheel/screens/register/signup.dart';
import 'package:greenwheel/screens/route/route.dart';
import 'package:greenwheel/screens/vehicles/AddVehicleScreen.dart';
import 'package:greenwheel/screens/vehicles/EditVehicleScreen.dart';
import 'package:greenwheel/screens/vehicles/vehicles.dart';
import 'package:greenwheel/screens/trophies/trophiesScreen.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/Bookings/block_booking_hours.dart';
import 'package:greenwheel/widgets/Bookings/past_confirmed_bookings.dart';
import 'package:greenwheel/widgets/Bookings/confirm_booking.dart';
import 'package:greenwheel/widgets/Bookings/past_confirmed_bookings.dart';
import 'package:greenwheel/widgets/Bookings/past_confirmed_bookings_user.dart';
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
                  GoRoute(path: 'rate/user',
                      builder: (context, state) {
                        final id = int.parse(state.params['id']!);
                        return RateUser(key: const Key("RateUser"), user_id: id);
                      }),
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
              path: 'bookings',
              builder: (context, state) =>
              bookingTabsUser(key: Key("Bookings_User")),
            ),
            GoRoute(
              path: 'bookings/:id',
              builder: (context, state) {
                final id = int.parse(state.params['id']!);
                return Reservate(key: const Key("Reservate"), id: id);
              },
            ),
            GoRoute(
              path: 'bookings/admin/block_hours/:id',
              builder: (context, state) {
                final id = int.parse(state.params['id']!);
                return BlockingBookingCalendar(key: const Key("BlockingBookingCalendar"), id: id);
              },
            ),
            GoRoute(
              path: 'vehicle',
              builder: (context, state) =>
              const MyVehicles(key: Key("Vehicle")),
            ),
            GoRoute(path: 'report/user/:id',
                builder: (context, state) {
                  final id = int.parse(state.params['id']!);
                  return ReportUser(key: const Key("ReportUser"), user_id: id);
                }),
            GoRoute(path: 'report/rating/:id',
                builder: (context, state) {
                  final id = int.parse(state.params['id']!);
                  return ReportComment(key: const Key("ReportComment"), comment_id: id);
                }),
            GoRoute(path: 'report/bike/:id',
                builder: (context, state) {
                  final id = int.parse(state.params['id']!);
                  return ReportBike(key: const Key("ReportBike"), bike_id: id);
                }),
            GoRoute(path: 'report/charger/:id',
                builder: (context, state) {
                  final id = int.parse(state.params['id']!);
                  return ReportCharger(key: const Key("ReportChargers"), charger_id: id);
                }),
            GoRoute(path: 'report/user/:id',
                builder: (context, state) {
                  final id = int.parse(state.params['id']!);
                  return ReportUser(key: const Key("ReportUser"), user_id: id);
                }),
            GoRoute(
                path: 'booking/accept',
                    builder: (context, state) {
                  return confirm_booking(key: const Key("AcceptBookings"));
                }),
            GoRoute(
                path: 'booking/admin/history',
                builder: (context, state) {
                  return bookingTabs(key: const Key("adminHistory"));
                }),

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
            GoRoute(
              path: 'chats',
              builder: (context, state) {
                return ChatListUsers(key: Key("ChatListUsers"));
              },
            ),
            GoRoute(
              path: 'chats/:id',
              builder: (context, state) {
                //TODO: mirar tema ruta parametres no donguin null value
                final id = int.parse(state.params['id']!);
                return ChatView(key: Key("ChatListUsers"), to_user: id);
              },
            ),
            GoRoute(
              path: 'chats/:id/messages',
              builder: (context, state) {
                final id = int.parse(state.params['id']!);
                final username = state.params['username']!;
                return ChatView(key: Key("ChatListUsers"), username: username, to_user: id);
              },
            ),
            GoRoute(
              path: 'chats/unread',
              builder: (context, state) {
                final unread = int.parse(state.params['unread']!);
                return ChatListUsers(key: Key("ChatListUsers"));
              },
            ),
            GoRoute(
              //TODO: revisar paths unread
              path: 'chats/unread/:id',
              builder: (context, state) {
                final unread = int.parse(state.params['unread']!);
                return ChatListUsers(key: Key("ChatListUsers"));
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

