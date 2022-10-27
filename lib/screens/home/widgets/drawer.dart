import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/profile/myprofile.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SimpleDrawer extends StatelessWidget {
  const SimpleDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        children: [
          crossFirstRow(context),

          DrawerHeader(

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
                CircularPercentIndicator(
                  radius: 42.0,
                  lineWidth: 7.0,
                  percent: 0.6,
                  center: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/47.jpg"),
                  ),
                  progressColor: Colors.green,
                  backgroundColor: Colors.white70,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Isslam Benali",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Nivel 10",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ), //UserAccountDrawerHeader
          //DrawerHeader
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: ListTile(
              leading: const Icon(Icons.person, size: 30.0),
              title: Text('My Profile', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.car_rental, size: 30.0),
              title: const Text('My Cars', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.history, size: 30.0),
              title: const Text('History', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.calendar_month, size: 30.0),
              title: const Text('My Bookings', style: TextStyle(fontSize: 18)),
              onTap: () {
                GoRouter.of(context).go('/booking');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.chat, size: 30.0),
              title: const Text('Chat', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.add, size: 30),
              title: const Text('Add point', style: TextStyle(fontSize: 18)),
              onTap: () {
                GoRouter.of(context).go('/chargers/add');
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                tileColor: Colors.white70,
                visualDensity: VisualDensity(vertical: -2),
                title: Center(
                  child: const Text('Log out',
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget crossFirstRow(BuildContext context) {
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.close, size: 30),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ]);
}
