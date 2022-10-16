import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenwheel/services/backend_service.dart';

import '../home/home.dart';

void main() {runApp(MaterialApp(
  title: 'bookings',
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
    BackendService.get('booking/').then((response) {
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          height: 220,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child:
            Column(
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.bolt, color: Colors.green),
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
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: FloatingActionButton.extended(
                            label: const Text('Cómo llegar'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon( // <-- Icon
                              Icons.bolt,
                              size: 35.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 60,
                      height: 60,
                      child: FittedBox(
                        child: FloatingActionButton.extended(
                          label: const Text('Chat'), // <-- Text
                          backgroundColor: Colors.green,
                          icon: const Icon( // <-- Icon
                            Icons.chat,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FittedBox(
                        child: FloatingActionButton.extended(
                          label: const Text('Cancelar'), // <-- Text
                          backgroundColor: Colors.red,
                          icon: const Icon( // <-- Icon
                            Icons.cancel,
                            size: 25.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          height: 220,
          width: double.maxFinite,
          child: const Card(
            elevation: 5,
            child: Text('Terrassa Rambla'),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          height: 220,
          width: double.maxFinite,
          child: const Card(
            elevation: 5,
            child: Text('Gran via'),
          ),
        ),
      ],
    );
  }


}



