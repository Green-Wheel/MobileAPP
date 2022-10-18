import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenwheel/services/backend_service.dart';

import '../home/home.dart';

void main() {runApp(MaterialApp(
  title: 'bookings',
  theme: ThemeData(
    scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
  ),
  home: Scaffold(
    appBar: AppBar(
      title: const Text('Mis Reservas'),
      centerTitle: true,
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Tornar a HomePage
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );*/
        },
      ),
    ),
    body: const BookingsList(),
  ),
));}


class BookingsList extends StatefulWidget {
  const BookingsList({Key? key}) : super(key: key);

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {

  List bookings = [];

  @override
  void initState() {
    super.initState();
    _getBookings();
  }

  void _getBookings() async {
    BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        setState(() {
          bookings = jsonResponse;
        });
      } else {
        print('Error getting bookings');
      }
    });
  }

  Widget _buildCard(String location, double rating, int distance, String time, bool match) => Card(
    //elevation: 20,
    color: CupertinoColors.white,
    shadowColor: Colors.black,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: SizedBox(
      height: 175,
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 3.0, top: 15.0) ,
            child: Row(
              children: [
                Text(location,
                    style: const TextStyle(fontWeight: FontWeight.w600)
                ),
                Icon(
                  Icons.bolt,
                  size: 25,
                  color: Colors.green[500],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow[500],
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow[500],
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow[500],
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow[500],
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow[500],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(rating.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 3.5),
            child: Row(
              children: [
                Text('Point of charge - ($distance km)',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),
            child: Row(
              children:[
                const Text('Available: ',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                ),
                Text(time,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: const [
                Icon (
                  Icons.check_circle_outline_rounded,
                  size: 20,
                  color: Colors.green,
                ),
                Padding(
                  padding:EdgeInsets.only(left: 5.0),
                  child: Text('Matching with your car charger',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,),
            child: Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue[50]!),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.blueAccent)
                              )
                          )
                      ),
                      onPressed:() {},
                      child: Row(
                        children: const [
                          Text('Route',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                          ),
                          Icon(
                            Icons.turn_slight_right_rounded,
                            size: 20,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue[50]!),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.blueAccent)
                              )
                          )
                      ),
                      onPressed:() {},
                      child: Row(
                        children: const [
                          Text('Chat ',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                          ),
                          Icon(
                            Icons.chat,
                            size: 20,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red[50]!),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed:() {},
                      child: Row(
                        children: const [
                          Text('Cancel ',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                          ),
                          Icon(
                            Icons.cancel,
                            size: 20,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        print(bookings[index]['publication']);
        return _buildCard("Passeig de la Bonanova", 4.5, 2, "10:00 - 11:00", true);
        //return _buildCard(bookings[index]['location'], bookings[index]['rating'], bookings[index]['distance'], bookings[index]['time'], bookings[index]['match']);
      },
    );
  }
    /*
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          height: 190,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child:
            Column(
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.bolt, color: Colors.green, size: 40),
                  title: Text('Passeig de la Bonanova'),
                  subtitle: Text('Punto de carga · (1 km)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,0,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cómo llegar'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.directions,
                              size: 35.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,0,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Chat'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.chat,
                              size: 25.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,0,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cancelar'), // <-- Text
                            backgroundColor: Colors.red,
                            icon: const Icon( // <-- Icon
                              Icons.cancel,
                              size: 30.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,0,10,0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          height: 190,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child:
            Column(
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.directions_bike, color: Colors.green, size: 40),
                  title: Text('Terrassa Rambla'),
                  subtitle: Text('Punto de bicicletas · (2 km)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cómo llegar'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.directions,
                              size: 35.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Chat'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.chat,
                              size: 25.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cancelar'), // <-- Text
                            backgroundColor: Colors.red,
                            icon: const Icon( // <-- Icon
                              Icons.cancel,
                              size: 30.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          height: 190,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child:
            Column(
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.directions_bike, color: Colors.green, size: 40),
                  title: Text('Gran Via'),
                  subtitle: Text('Punto de bicicletas · (3 km)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cómo llegar'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.directions,
                              size: 35.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Chat'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.chat,
                              size: 25.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FittedBox(
                        child:
                        Container(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cancelar'), // <-- Text
                            backgroundColor: Colors.red,
                            icon: const Icon( // <-- Icon
                              Icons.cancel,
                              size: 30.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  */

}



