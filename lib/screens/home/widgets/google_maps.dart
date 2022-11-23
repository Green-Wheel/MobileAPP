import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/widgets/button_list_screen_chargers.dart';
import 'package:greenwheel/widgets/card_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../serializers/bikes.dart';
import '../../../serializers/chargers.dart';
import '../../../services/backendServices/bikes.dart';
import '../../../services/backendServices/chargers.dart';
import '../../../widgets/bike_card_info.dart';
import '../../../widgets/button_list_screen_bikes.dart';

class GoogleMapsWidget extends StatefulWidget {
  int index;
  Set<Polyline>? polylines = {};

  GoogleMapsWidget({Key? key, required this.index, this.polylines}) : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  late GoogleMapController mapController;
  bool permissionGranted = false;
  Position _position = const Position(
      latitude: 41.7285833,
      longitude: 1.8130899,
      timestamp: null,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Set<Marker> markers = {};
  final Map<MarkerId, Marker> markerMap = {};
  //late Position _actualMarcador = _position;
  late double latitud_act;
  late double longitud_act;
  late Marker marcador_actual;
  late String id_marcador;
  List markersList = [];
  DetailedCharherSerializer? markedCharger;
  DetailedBikeSerializer? markedBike;
  bool is_visible = false;
  final panelController = PanelController();
  bool is_visible_panel = false;

  void _getChargers() async {
    List chargersList = await ChargerService.getChargers();
    setState(() {
      markersList = chargersList;
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        String chargerType = markersList[i].charger_type;
        _addMarker(latitude, longitude, chargerType, id);
      }
    });
  }

  void _getBikes() async {
    List bikeList = await BikeService.getBikes();
    setState(() {
      markersList = bikeList;
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        _addBikeMarker(latitude, longitude, id);
      }
    });
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
      is_visible = false;
    });
    _getChargers();
    print(widget.index);

    if (widget.index == 0) {
      _getChargers();
    } else if (widget.index == 1) {
      _getBikes();
    }
    super.initState();
  }

  void _addBikeMarker(double lat, double log, int id) async { // TODO: Falta BikeType com a argument
    final iconMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.2,), "assets/images/punt_bicicleta.png");
    print('afegir bici');
    final Marker marcador = Marker(
        markerId: MarkerId(id.toString()),
        position: LatLng(lat, log),
        onDrag: null,
        icon: iconMarker,
        onTap: () {
          setState(() {
            is_visible = false;
          });
          setState(() {
            id_marcador = id.toString();
            is_visible = true;
            _getBike(id);
          });
        } //_onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id.toString())] = marcador;
  }

  void _addMarker(double lat, double log, String chargerType, int id) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.2,), "assets/images/punt_carregador.png");
    final Marker marcador = Marker(
        markerId: MarkerId(id.toString()),
        position: LatLng(lat, log),
        onDrag: null,
        icon: iconMarker,
        onTap: () {
          setState(() {
            is_visible = false;
          });
          setState(() {
            id_marcador = id.toString();
            is_visible = true;
            _getCharger(id);
          });
        } //_onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id.toString())] = marcador;
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(41.7285833, 1.8130899),
    zoom: 8.0,
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarLocation);
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    setState(() {
      permissionGranted = true;
    });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _getCurrentLocation() async {
    _position = await _determinePosition();
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_position.latitude, _position.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  void _updateCurrentLocation() async {
    _position = await _determinePosition();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_position.latitude, _position.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  void onCameraMove(CameraPosition cameraPosition) {
    //print('$cameraPosition');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kInitialPosition,
            markers: markers,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            trafficEnabled: true,
            mapToolbarEnabled: false,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            liteModeEnabled: false,
            onTap: (latLong) {
                (SnackBar(
                  content: Text(
                      'Tapped location LatLong is (${latLong.latitude},${latLong.longitude})'),
                ));
              },
              onCameraMove: onCameraMove,
            ),
            is_visible ? show_card() : Container(),
          ],
        ),
        floatingActionButton:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: !is_visible? [
            listButton(),
            SizedBox(height: 10),
            currentLocationActionButton(),
            ] : <Widget>[
              listButton(),
              SizedBox(height: 10),
              currentLocationActionButton(),
              SizedBox(height: 165),],
        ));
  }

  Widget listButton() {
    if (widget.index == 0) {
      return const ButtonListScreenChargersWidget();
    } else {
      return const ButtonListScreenBikesWidget();
    }
  }

  Widget show_card() {
    if (widget.index == 0) {
      print("do charger");
      return SlidingUpPanel(
        // https://www.youtube.com/watch?v=s9XHOQeIeZg&ab_channel=JohannesMilke
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: 175.0,
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          backdropEnabled: true,
          panelBuilder: (controller) => buildSlidingUpPanelCharger(
            controller: controller,
            panelController: panelController,
          ), borderRadius: const BorderRadius.vertical(top: Radius.circular(18)));
    } else {
      print("do bike");
      return SlidingUpPanel(
        // https://www.youtube.com/watch?v=s9XHOQeIeZg&ab_channel=JohannesMilke
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: 175.0,
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          backdropEnabled: true,
          panelBuilder: (controller) => buildSlidingUpPanelBike(
            controller: controller,
            panelController: panelController,
          ), borderRadius: const BorderRadius.vertical(top: Radius.circular(18)));
    }
  }

  void _getCharger(int id) async {
    DetailedCharherSerializer? charger = await ChargerService.getCharger(id);
    print(charger);
    if (charger != null) {
      setState(() {
        markedCharger = charger;
      });
    }
  }

  Widget buildSlidingUpPanelCharger({required ScrollController controller, required PanelController panelController}) {
      String? descrip = utf8.decode(utf8.encode(markedCharger!.title!));
      //descrip = title_parser(descrip);

      //Generación rate aleatoria (harcode rate) --> Quan estigui el sistema de rates
      Random random = Random();
      int min = 2, max = 6;
      int num = (min + random.nextInt(max - min));
      double numd = num.toDouble();

      //Obtencion del numero de tipos de cargadores
      List<ConnectionType> types = [];
      for (int i = 0; i < markedCharger!.connection_type.length; ++i) {
        types.add(markedCharger!.connection_type[i]);
      }

      // available
      // match

      return CardInfoWidget(location: descrip, rating: numd, types: types, available: true, match: true);
  }


  void _getBike(int id) async {
    DetailedBikeSerializer? bike = await BikeService.getBike(id);
    print(bike);
    if (bike != null) {
      setState(() {
        markedBike = bike;
      });
    }
  }

  Widget buildSlidingUpPanelBike({required ScrollController controller, required PanelController panelController}) {
    String? descrip = utf8.decode(utf8.encode(markedBike!.title!));
    //descrip = title_parser(descrip);

    //Generación rate aleatoria (harcode rate) --> Quan estigui el sistema de rates
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    double numd = num.toDouble();

    // available

    return BikeCardInfoWidget(location: descrip, rating: numd, available: true);
  }

  String? title_parser(String? description){
    description = description?.replaceAll("Ãa", "i");
    description = description?.replaceAll("Ã", "à");
    description = description?.replaceAll("àa", "ia");
    description = description?.replaceAll("Ã³", "ó");
    description = description?.replaceAll("à³", "ó");
    description = description?.replaceAll("Ã²", "ò");
    description = description?.replaceAll("à²", "ò");
    description = description?.replaceAll("Ã§", "ç");
    description = description?.replaceAll("à§", "ç");
    description = description?.replaceAll("Ã©", "é");
    description = description?.replaceAll("à¨", "è");
    description = description?.replaceAll("à©", "è");
    description = description?.replaceAll("2 -", "2\n");
    description = description?.replaceAll("6 -  ", "6\n");
    description = description?.replaceAll("³-", "\n");
    description = description?.replaceAll("er-Al", "er\nAl");
    description = description?.replaceAll("a-Ca", "a\nCa");
    description = description?.replaceAll(", Ap", "\nAp");
    description = description?.replaceAll("-Ca", "\nCa");
    description = description?.replaceAll(", Ca", "\nCa");
    description = description?.replaceAll(" QR", "\nQR");
    description = description?.replaceAll("37 - S", "37\nS");
    description = description?.replaceAll("res SO", "res\nSO");
    description = description?.replaceAll("-Ca", "\nCa");
    description = description?.replaceAll("ó-Pl", "ó\nPl");
    description = description?.replaceAll("mans i ", "mans\ni ");
    description = description?.replaceAll("T-I", "T\nI");
    description = description?.replaceAll("A  Torr", "A\nTorr");
    description = description?.replaceAll("Mont-Roig", "Mont\nRoig");
    description = description?.replaceAll("a Sup", "a\nSup");
    description = description?.replaceAll("Despà", "Despí");
    if (description!.length >= 40){
      description = description.replaceAll(" - ", "\n");
      //description = description.replaceAll("-", "\n");
      description = description.replaceAll("- ", "\n");
      description = description.replaceAll(")(", ")\n(");
      description = description.replaceAll(" (", "\n(");
      description = description.replaceAll("E L'", "E\nL'");
    }
    if (description.length < 40){
      description = description.replaceAll(") ", ")\n");
      description = description.replaceAll(" (", "\n(");
      description = description.replaceAll("m-", "m\n");
    }
    return description;
  }



  Widget currentLocationActionButton() {
    if (widget.index == 0) {
      return FloatingActionButton(
        heroTag: "btn1",
        onPressed: _updateCurrentLocation,
        backgroundColor: Colors.white,
        child: permissionGranted
            ? const Icon(Icons.my_location, color: Colors.green, size: 30.0)
            : const Icon(Icons.question_mark, color: Colors.red, size: 25.0),
      );
    } else {
      return FloatingActionButton(
        heroTag: "btn2",
        onPressed: _updateCurrentLocation,
        backgroundColor: Colors.white,
        child: permissionGranted
            ? const Icon(Icons.my_location, color: Colors.blue, size: 30.0)
            : const Icon(Icons.question_mark, color: Colors.red, size: 25.0),
      );
    }
  }

  var snackBarLocation = SnackBar(
      content: const Text('snackbar_location_denied_label').tr(),
      action: SnackBarAction(
        textColor: Colors.green,
        label: 'snackbar_location_denied_action'.tr(),
        onPressed: () {
          openAppSettings();
        },
      ));
}
