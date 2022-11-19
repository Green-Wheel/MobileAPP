import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/widgets/button_list_screen_chargers.dart';
import 'package:greenwheel/widgets/card_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/backendServices/bikes.dart';
import '../../../services/backendServices/publicChargers.dart';
import '../../../services/backendServices/privateChargers.dart';
import 'package:greenwheel/widgets/bike_card_info.dart';

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
  late Position _actualMarcador = _position;
  late double latitud_act;
  late double longitud_act;
  late Marker marcador_actual;
  late String id_marcador;
  List markersList = [];
  bool is_visible = false;

  void _drawPublicChargers() async {
    List? publicChargerList = await PublicChargerService.getPublicChargers();
    setState(() {
      if (publicChargerList != null) {
        markersList = publicChargerList;
        for (int i = 0; i < markersList.length; i++) {
          Map localization = markersList[i]['localization'];
          double latitude = localization['latitude'];
          double longitude = localization['longitude'];
          if (markersList[i]['direction'] == null) {
            markersList[i]['direction'] = "No description";
          }
          _addMarker(latitude, longitude, markersList[i]['description'], markersList[i]['direction'], 5.0, 2, "10:00 - 20:00h");
        }
      }
    });
  }

  void _drawPrivateChargers() async {
    List? privateChargerList = await PrivateChargerService.getPrivateChargers();
    setState(() {
      if (privateChargerList != null) {
        markersList = privateChargerList;
        for (int i = 0; i < markersList.length; i++) {
          Map localization = markersList[i]['localization'];
          double latitude = localization['latitude'];
          double longitude = localization['longitude'];
          if (markersList[i]['direction'] == null) {
            markersList[i]['direction'] = "No description";
          }
          _addMarker(latitude, longitude, markersList[i]['description'], markersList[i]['direction'], 5.0, 2, "10:00 - 20:00h");
        }
      }
    });
  }

  void _drawBikes() async {
    List? bikesList = await Bikes.getBikes();
    setState(() {
      if (bikesList != null) {
        markersList = bikesList;
        for (int i = 0; i < markersList.length; i++) {
          Map localization = markersList[i]['localization'];
          double latitude = localization['latitude'];
          double longitude = localization['longitude'];
          if (markersList[i]['direction'] == null) {
            markersList[i]['direction'] = "No description";
          }
          _addBikeMarker(latitude, longitude, markersList[i]['description'], markersList[i]['direction'], 5.0, 2, "10:00 - 20:00h");
        }
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
    print(widget.index);

    if (widget.index == 0) {
      _drawPublicChargers();
      _drawPrivateChargers();
    } else if (widget.index == 1) {
      _drawBikes();
    }
    super.initState();
  }

  void _addBikeMarker(double lat, double log, String id, String address, double rate, int distance, String time) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.2,), "assets/images/punt_bicicleta.png");
    final Marker marcador = Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, log),
        onDrag: null,
        icon: iconMarker,
        onTap: () {
          setState(() {
            is_visible = false;
          });
          setState(() {
            id_marcador = id;
            is_visible = true;
          });
        } //_onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id)] = marcador;
  }

  void _addMarker(double lat, double log, String id, String address, double rate, int distance, String time) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.2,), "assets/images/punt_carregador.png");
    final Marker marcador = Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, log),
        onDrag: null,
        icon: iconMarker,
        onTap: () {
          setState(() {
            is_visible = false;
          });
          setState(() {
            id_marcador = id;
            is_visible = true;
          });
        } //_onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id)] = marcador;
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

          is_visible ? show_card() : Container()
        ],
      ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonListScreenChargersWidget(),
            SizedBox(height: 10),
            currentLocationActionButton(),
          ],
        ));
  }

  String title_parser(String description){
    description = description.replaceAll("Ãa", "i");
    description = description.replaceAll("Ã", "à");
    description = description.replaceAll("àa", "ia");
    description = description.replaceAll("Ã³", "ó");
    description = description.replaceAll("à³", "ó");
    description = description.replaceAll("Ã²", "ò");
    description = description.replaceAll("à²", "ò");
    description = description.replaceAll("Ã§", "ç");
    description = description.replaceAll("à§", "ç");
    description = description.replaceAll("Ã©", "é");
    description = description.replaceAll("à¨", "è");
    description = description.replaceAll("à©", "è");
    description = description.replaceAll("2 -", "2\n");
    description = description.replaceAll("6 -  ", "6\n");
    description = description.replaceAll("³-", "\n");
    description = description.replaceAll("er-Al", "er\nAl");
    description = description.replaceAll("a-Ca", "a\nCa");
    description = description.replaceAll(", Ap", "\nAp");
    description = description.replaceAll("-Ca", "\nCa");
    description = description.replaceAll(", Ca", "\nCa");
    description = description.replaceAll(" QR", "\nQR");
    description = description.replaceAll("37 - S", "37\nS");
    description = description.replaceAll("res SO", "res\nSO");
    description = description.replaceAll("-Ca", "\nCa");
    description = description.replaceAll("ó-Pl", "ó\nPl");
    description = description.replaceAll("mans i ", "mans\ni ");
    description = description.replaceAll("T-I", "T\nI");
    description = description.replaceAll("A  Torr", "A\nTorr");
    description = description.replaceAll("Mont-Roig", "Mont\nRoig");
    description = description.replaceAll("a Sup", "a\nSup");
    description = description.replaceAll("Despà", "Despí");
    if (description.length >= 40){
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

  Widget show_card() {
    if (widget.index == 0) {
      print("do charger");
      return show_card_charger();
    } else {
      print("do bike");
      return show_card_bike();
    }
  }

  Widget show_card_charger(){
    //Obtencion posicion del elemento en el array markersList para obtener los parametros del marcador en cuestion
    int pos_marker = 0;
    for (int i = 0; i < markersList.length; i++){
      if (markersList[i]['description'] == id_marcador){
        pos_marker = i;
        print('id $pos_marker');
        print(is_visible);
      }
    }
    //Generación rate aleatoria (harcode rate)
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    double numd = num.toDouble();

    //Obtencion del numero de tipos de cargadores
    int types = markersList[pos_marker]['connection_type'].length;

    //Arreglo del titulo del cargador respecto a los datos del json
    String description = markersList[pos_marker]['description'];
    description = title_parser(description);

    //Mirar el tipo de la variable porque to_do  da null
    bool available = true;
    //avaliable da null
    if (markersList[pos_marker]['description'] == "false") available = false;

    return CardInfoWidget(location: description, rating: numd, types: types, available: available, match: true);
  }


  Widget show_card_bike(){
    //Obtencion posicion del elemento en el array markersList para obtener los parametros del marcador en cuestion
    int pos_marker = 0;
    for (int i = 0; i < markersList.length; i++){
      if (markersList[i]['description'] == id_marcador){
        pos_marker = i;
        print('id $pos_marker');
        print(is_visible);
      }
    }
    //Generación rate aleatoria (harcode rate)
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    double numd = num.toDouble();

    //Obtencion del numero de tipos de cargadores
    int types = markersList[pos_marker]['connection_type'].length;

    //Arreglo del titulo del cargador respecto a los datos del json
    String description = markersList[pos_marker]['description'];
    description = title_parser(description);

    //Mirar el tipo de la variable porque to_do  da null
    bool available = true;
    //avaliable da null
    if (markersList[pos_marker]['description'] == "false") available = false;

    return BikeCardInfoWidget(location: description, rating: numd, types: types, available: available, match: true);
  }


  Widget card_charger(String description, double rating, int types, bool available, bool match) {
    return Padding(
      padding: const EdgeInsets.only(top: 470),
      child: CardInfoWidget(location: description, rating: rating, types: types, available: available, match: true),
    );
  }

  Widget currentLocationActionButton() {
    return FloatingActionButton(
      onPressed: _updateCurrentLocation,
      backgroundColor: Colors.white,
      child: permissionGranted
          ? const Icon(Icons.my_location, color: Colors.green, size: 30.0)
          : const Icon(Icons.question_mark, color: Colors.red, size: 25.0),
    );
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
