import 'package:flutter/material.dart';
import 'package:greenwheel/screens/profile/myprofile.dart';


class SimpleDrawer extends StatelessWidget {
  const SimpleDrawer( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      width: 800,
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(left:0.0,top:25.0),
        children:[
          crossFirstRow(context),
          const DrawerHeader(
            decoration: BoxDecoration(
              image:  DecorationImage(
                scale: 1.0,
                image: NetworkImage('https://media.istockphoto.com/vectors/catalonia-map-glowing-neon-sign-on-brick-wall-background-vector-id1283152906?b=1&k=20&m=1283152906&s=612x612&w=0&h=C1grjJ9XWFnQT9B8dX7O8QWFo5vy-HagjvTlytytTAs='),
                fit: BoxFit.cover,
              ),
            ), //BoxDecoration
            child: Padding(
              padding: EdgeInsets.only(left: 130.0, bottom:0.0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountName: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text("DASDSA",
                 style: TextStyle(fontSize: 20,color: Colors.lightGreen),
                  ),
                ),
                accountEmail: Padding(
                  padding: const EdgeInsets.only(top: 30.0,left:0.0),
                  child: Text("Isslam Benali",
                      style: TextStyle(fontSize:20,color:Colors.lightGreen)),
                ),
                currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: Padding(
                    padding: EdgeInsets.only(bottom:0.0,left:15.0),
                    child: Icon(Icons.account_circle,size:80,color:Colors.green),
                  ),
                ), //circleAvatar
              ), //UserAccountDrawerHeader
          ),
          //DrawerHeader
          Padding(
            padding: EdgeInsets.only(left: 110.0, top:10.0),
            child: ListTile(
                leading: const Icon(Icons.person,size:40),
                title:  Text(' My Profile ',style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0, top:0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.car_rental,size:40),
              title: const Text(' My Cars ',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
              },
           ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0, right:0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.history,size:40),
              title: const Text(' History ',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0, right:0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.calendar_month,size:40),
              title: const Text(' My Bookings ',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0, right:0.0),
            child:ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.chat,size:40),
              title: const Text(' Chat',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 110.0, right:0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              leading: const Icon(Icons.add,size:40),
              title: const Text('My points',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 166.0, right:0.0),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -2),
              title: const Text('Log out',style: TextStyle(fontSize: 20,color:Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget crossFirstRow(BuildContext context) {
  return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.close,size:30),
          onPressed: () {Navigator.pop(context);},
        ),
      ]
  );
}
