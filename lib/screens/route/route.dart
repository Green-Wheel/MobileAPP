import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import 'package:greenwheel/screens/route/widgets/baterySelector.dart';
import 'package:greenwheel/screens/route/widgets/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../serializers/maps.dart';
import '../../serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../../services/generalServices/LoginService.dart';
import '../../utils/geocoding.dart';
import '../../utils/lang_config.dart';
import '../../utils/map_directions.dart';

//https://medium.com/@shiraz990/flutter-fetching-google-directions-using-changenotifierprovider-f642adbe6cf4
//https://github.com/shiraz990/FlutterDirectionAPI/blob/main/lib/location_map.dart
//https://medium.com/@rohanarafat86/drawing-route-direction-in-flutter-using-openrouteservice-api-and-google-maps-in-flutter-4431a2989dd5
// https://medium.com/@stefanodecillis/flutter-using-google-maps-and-drawing-routes-100829419faf

class RoutePage extends StatefulWidget {
  final String long;
  final String lat;
  int pubication_id;

  RoutePage({Key? key, required this.lat, required this.long, required this.pubication_id})
      : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  Set<Polyline> polylines = {};
  final panelController = PanelController();
  Direction? routeInfo;
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final _loggedInStateInfo = LoginService();

  var cars_of_user = [];
  var selected_car;
  int batery = -1;
  bool batterySufficient= true ;

  @override
  void initState() {
    super.initState();
    getPolylines();
    getUserCars();
  }

  void getUserCars() async {
    var carsAux = await VehicleService.getVehicles();
    var user = _loggedInStateInfo.user_info;
    cars_of_user = carsAux;
    if(cars_of_user.length != 0){
      print(user!['selected_car']);
      if(user!['selected_car'] == null){
        selected_car = cars_of_user[0].id;
      }else {
        selected_car = carsAux
            .where((element) => element.id == user!['selected_car'])
            .toList()[0]
            .id;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showModal(context);
      });
    }
  }

  void getPolylines() {
    Geocoding.getCurrentPosition().then((position) => {
          MapDirections.getDirections(
                  LatLang(lat: position.latitude, lng: position.longitude),
                  LatLang(
                      lat: double.parse(widget.lat),
                      lng: double.parse(widget.long)),
                  LangConfig.getStringFromLocale(context.locale))
              .then((value) => {
                    setState(() {
                      routeInfo = value;
                      originController.text = value.startAddress;
                      destinationController.text = value.endAddress;
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

  void sufficientBattery() async {
    var vehicle = await VehicleService.getVehicle(selected_car);
    setState(() {
      batterySufficient = batery == -1 ? true : vehicle['model']['autonomy'] * double.parse('${batery}')/100 > double.parse(routeInfo!.distance.split(' ')[0].replaceAll(',', '.'));
    });
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 250,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                    BatterySelector(
                      user_cars: cars_of_user,
                      selected_car: selected_car,
                      callbackBattery: (value) {batery = int.parse(value);},
                      callbackCar: (value) {selected_car = value;},
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          sufficientBattery();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirmar'),
                      ),
                    )
                  ],
                ),
              )));
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
                            searchField("Origin", originController),
                            const SizedBox(
                              height: 10,
                            ),
                            searchField("Destination", destinationController),
                          ])),
                        ])),
              )),
        ),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(bottom: 135),
            child: GoogleMapsWidget(index: 0, polylines: polylines, publicationId: widget.pubication_id),
          ),
          SlidingUpPanel(
              // https://www.youtube.com/watch?v=s9XHOQeIeZg&ab_channel=JohannesMilke
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: 200.0,
              controller: panelController,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              backdropEnabled: true,
              panelBuilder: (controller) => PanelWidget(
                    controller: controller,
                    sufficientBattery: batterySufficient,
                    panelController: panelController,
                    routeInfo: routeInfo,
                  ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
        ]));
  }
}

Widget searchField(hint, controller) {
  return Expanded(
      child: TextField(
    cursorColor: Colors.green,
    enabled: false,
    maxLines: 1,
    controller: controller,
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
