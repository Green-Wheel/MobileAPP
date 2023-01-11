import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/profile/myprofile.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../services/backendServices/logout_service.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../services/generalServices/LoginService.dart';
import '../../../widgets/accountIcon.dart';

class SimpleDrawer extends StatefulWidget {
  SimpleDrawer({Key? key}) : super(key: key);

  State<SimpleDrawer> createState() =>_SimpleDrawer();
}

class _SimpleDrawer extends State<SimpleDrawer>{

  final _loggedInStateInfo = LoginService();
  var userData;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    var data = await _loggedInStateInfo.user_info;
    setState(() {
      userData = data;
    });
  }
  bool logged = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/28),
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
            height: MediaQuery.of(context).size.height/3.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(27, 29, 27, 1),
                  Color.fromRGBO(0, 49, 69, 1),
                ],
              ),
            ), //BoxDecoration
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AccountIcon(percent: 0.5,path_image: userData != null ? userData['profile_picture']: null),
                Text(
                  userData != null
                      ? userData['first_name'] + " " + userData['last_name']
                      : "User Name",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text("Level ${userData != null ?userData['level']: ''} ",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ), //UserAccountDrawerHeader
          //DrawerHeader
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 0.0),
            child: ListTile(
              leading: const Icon(Icons.person, size: 30.0),
              title: Hero(
                        tag: "1",
                        child: const Text('My Profile', style: TextStyle(fontSize: 18)),
                      ),
              onTap: () {
                int id = userData['id'];
                GoRouter.of(context).push('/profile/$id');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.car_rental, size: 30.0),
              title: Hero(
                tag: "2",
                child: const Text('My Vehicles', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                GoRouter.of(context).push('/vehicle');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.history, size: 30.0),
              title: Hero(
                tag: "3",
                child: const Text('History', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                GoRouter.of(context).push('/trophies');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.calendar_month, size: 30.0),
              title: Hero(
                tag: "4",
                child: const Text('My Bookings', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                GoRouter.of(context).push('/bookings');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.chat, size: 30.0),
              title: Hero(
                tag: "5",
                child: const Text('Chat', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.charging_station, size: 30),
              title: Hero(
                tag: "12",
                child: const Text('Add Charger', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                GoRouter.of(context).push('/chargers/add');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.directions_bike_sharp, size: 30),
              title: Hero(
                tag: "6",
                child: const Text('Add Bikes', style: TextStyle(fontSize: 18)),
              ),
              onTap: () {
                GoRouter.of(context).push('/bikes/add');
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Align(
                        alignment: Alignment.center,
                        child :Container(
                            decoration: new BoxDecoration(color: Colors.lightBlueAccent),
                            child: ListTile(
                              visualDensity: VisualDensity(vertical: -2),
                              leading: const Icon(Icons.help, size: 30),
                              title: Hero(
                                tag: "7",
                                child: const Text('Help & Comments', style: TextStyle(fontSize: 18)),
                              ),
                              onTap: () {
                              },
                            ),
                          )
                    ),
          ),
          /*
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Align(
                alignment: Alignment.center,
                child :Container(
                  decoration: new BoxDecoration(color: Colors.grey),
                  child: ListTile(
                    visualDensity: VisualDensity(vertical: -2),
                    leading: const Icon(Icons.account_box_rounded, size: 30),
                    title: Hero(
                      tag: "8",
                      child: const Text('Change Accounts', style: TextStyle(fontSize: 18)),
                    ),
                    onTap: () {
                    },
                  ),
                )
            ),
          ),
           */
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: logged ?
              Align(
                alignment: Alignment.center,
                child: ListTile(
                  tileColor: Colors.redAccent,
                        visualDensity: VisualDensity(vertical: -2),
                        title: Hero(
                          tag: "9",
                          child: Center(
                            child: const Text('Log Out',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        onTap: () async {
                          final logged_out =
                              await LogoutService.logOutUser(context);
                          print(logged_out);
                          if (logged_out) {
                            GoRouter.of(context).push('/login');
                          }
                        },
                      ),
              ): Text("")
          ),
        ],
      ),
    );
  }
}
