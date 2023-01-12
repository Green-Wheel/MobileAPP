

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/Bookings/booking_list.dart';


void main() => runApp(
    MaterialApp(
        home: bookingTabsUser()
    )
);

class bookingTabsUser extends StatefulWidget {
  bookingTabsUser({Key? key}) : super(key: key);

  @override
  State<bookingTabsUser> createState() => _bookingTabsUserState();
}

class _bookingTabsUserState extends State<bookingTabsUser> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Reservas a tus puntos"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [

                Tab(
                  text: "Próximas",
                  icon: Icon(Icons.pending_actions, color: Colors.white,),),
                Tab(
                  text: "Pasadas",
                  icon: Icon(Icons.history, color: Colors.white,),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              booking_list(getFinisheds: false,isOwner: false,),
              booking_list(getFinisheds: true,isOwner: false,),
            ],
          )
      ),
    );
  }
}
