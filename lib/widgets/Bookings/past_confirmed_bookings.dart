

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/Bookings/booking_list.dart';


void main() => runApp(
    MaterialApp(
        home: bookingTabs()
    )
);

class bookingTabs extends StatefulWidget {
  bookingTabs({Key? key}) : super(key: key);

  @override
  State<bookingTabs> createState() => _bookingTabsState();
}

class _bookingTabsState extends State<bookingTabs> {

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
              booking_list(getFinisheds: false,),
              booking_list(getFinisheds: true,),
            ],
          )
      ),
    );
  }
}
