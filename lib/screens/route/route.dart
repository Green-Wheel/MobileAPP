import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';

//https://medium.com/@shiraz990/flutter-fetching-google-directions-using-changenotifierprovider-f642adbe6cf4
//https://github.com/shiraz990/FlutterDirectionAPI/blob/main/lib/location_map.dart
//https://medium.com/@rohanarafat86/drawing-route-direction-in-flutter-using-openrouteservice-api-and-google-maps-in-flutter-4431a2989dd5
// https://medium.com/@stefanodecillis/flutter-using-google-maps-and-drawing-routes-100829419faf
//
class RoutePage extends StatefulWidget {
  final String long;
  final String lat;

  const RoutePage({Key? key, required this.long, required this.lat})
      : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Container(
              color: Colors.orange,
              child: Column(
                children: [
                  Text('1'),
                  Text('2'),
                  Text('3'),
                  Text('4'),
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: GoogleMapsWidget(),
      ),
    );
  }
}
