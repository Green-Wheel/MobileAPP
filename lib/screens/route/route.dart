import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import 'package:greenwheel/screens/route/widgets/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../serializers/maps.dart';
import '../../utils/geocoding.dart';
import '../../utils/map_directions.dart';

//https://medium.com/@shiraz990/flutter-fetching-google-directions-using-changenotifierprovider-f642adbe6cf4
//https://github.com/shiraz990/FlutterDirectionAPI/blob/main/lib/location_map.dart
//https://medium.com/@rohanarafat86/drawing-route-direction-in-flutter-using-openrouteservice-api-and-google-maps-in-flutter-4431a2989dd5
// https://medium.com/@stefanodecillis/flutter-using-google-maps-and-drawing-routes-100829419faf

class RoutePage extends StatefulWidget {
  final String long;
  final String lat;

  const RoutePage({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  Set<Polyline>? polylines = {};
  final _formKey = GlobalKey<FormState>();
  final panelController = PanelController();

  @override
  void initState() {
    super.initState();
    getPolylines();
  }

  void getPolylines() {
    Geocoding.getCurrentPosition().then((position) => {
          MapDirections.getDirections(
                  LatLang(lat: position.latitude, lng: position.longitude),
                  LatLang(
                      lat: double.parse(widget.lat),
                      lng: double.parse(widget.long)))
              .then((value) => {
                    setState(() {
                      polylines!.add(Polyline(
                          polylineId: const PolylineId("poly"),
                          color: Colors.blue,
                          width: 8,
                          zIndex: 9999999999999,
                          points: value.polylinePoints
                              .map((e) => LatLng(e.lat, e.lng))
                              .toList()));
                    })
                  })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                context.go('/');
              },
            ),
            flexibleSpace: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(55, 35, 50, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        decorativeIcons(),
                        Expanded(
                            child: Column(children: [
                          searchField("Origin"),
                          const SizedBox(
                            height: 10,
                          ),
                          searchField("Destination"),
                        ])),
                      ])),
            )),
      ),
      body: SlidingUpPanel(
          // https://www.youtube.com/watch?v=s9XHOQeIeZg&ab_channel=JohannesMilke
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: MediaQuery.of(context).size.height * 0.2,
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          backdropEnabled: true,
          body: Expanded(
            child: GoogleMapsWidget(polylines: polylines),
          ),
          panelBuilder: (controller) => PanelWidget(
                controller: controller,
                panelController: panelController,
              ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
    );
  }
}

Widget searchField(hint) {
  return Expanded(
      child: TextField(
    cursorColor: Colors.green,
    enabled: false,
    maxLines: 1,
    //controller: controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 1.0),
      ),
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black),
    ),
  ));
}

Widget decorativeIcons() {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.trip_origin,
            color: Colors.blue,
            size: 20,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.grey,
            size: 20,
          ),
          Icon(
            Icons.location_on,
            color: Colors.red,
            size: 20,
          ),
        ]),
  );
}