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
import 'bike_filters_map.dart';
import 'charger_filters_map.dart';

class GoogleMapsWidget extends StatefulWidget {
  int index;
  Set<Polyline>? polylines = {};
  int? publicationId;


  GoogleMapsWidget(
      {Key? key, required this.index, this.polylines, this.publicationId})
      : super(key: key);

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
  bool scrolledup = false;
  bool loading_charger = false;
  bool loading_bike = false;
  bool _publicationloaded = false;

  void _showAvisNoEsPodenCarregarCarregadors() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chargers Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load chargers'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAvisNoEsPodenCarregarBicis() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bike Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load bikes'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getChargers() async {
    List chargersList = await ChargerService.getChargers();
    if (chargersList.isEmpty) {
      _showAvisNoEsPodenCarregarCarregadors();
    }
    setState(() {
      markersList = chargersList;
      removeMarkers();
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        String chargerType = markersList[i].charger_type;
        _addMarker(latitude, longitude, chargerType, id);
      }
      loading_charger = true;
    });
  }

  void _getPublicChargers() async {
    List chargersList = await ChargerService.getPublicChargers();
    if (chargersList.isEmpty) {
      _showAvisNoEsPodenCarregarCarregadors();
    }
    setState(() {
      markersList = chargersList;
      removeMarkers();
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        String chargerType = markersList[i].charger_type;
        _addMarker(latitude, longitude, chargerType, id);
      }
      loading_charger = true;
    });
  }

  void _getPrivateChargers() async {
    List chargersList = await ChargerService.getPrivateChargers();
    for (int i = 0; i < chargersList.length; i++) {
      print(chargersList[i].charger_type);
    }
    if (chargersList.isEmpty) {
      _showAvisNoEsPodenCarregarCarregadors();
    }
    setState(() {
      markersList = chargersList;
      removeMarkers();
      print(markersList.length);
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        String chargerType = markersList[i].charger_type;
        _addMarker(latitude, longitude, chargerType, id);
      }
      loading_charger = true;
    });
  }

  void _getBikes() async {
    List bikeList = await BikeService.getBikes();
    if (bikeList.isEmpty) {
      _showAvisNoEsPodenCarregarBicis();
    }
    setState(() {
      markersList = bikeList;
      removeMarkers();
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        _addBikeMarker(latitude, longitude, id);
      }
      loading_bike = true;
    });
  }

  void _getNormalBikes() async {
    List bikeList = await BikeService.getNormalBikes();
    if (bikeList.isEmpty) {
      _showAvisNoEsPodenCarregarBicis();
    }
    setState(() {
      markersList = bikeList;
      removeMarkers();
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        _addBikeMarker(latitude, longitude, id);
      }
      loading_bike = true;
    });
  }

  void _getElectricBikes() async {
    List bikeList = await BikeService.getElectricBikes();
    if (bikeList.isEmpty) {
      _showAvisNoEsPodenCarregarBicis();
    }
    setState(() {
      markersList = bikeList;
      removeMarkers();
      for (int i = 0; i < markersList.length; i++) {
        int id = markersList[i].id;
        double latitude = markersList[i].localization.latitude;
        double longitude = markersList[i].localization.longitude;
        _addBikeMarker(latitude, longitude, id);
      }
      loading_bike = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
      is_visible = false;
      scrolledup = false;
    });
    print(widget.index);

    if (widget.index == 0) {
      _getChargers();
    } else if (widget.index == 1) {
      _getBikes();
    }
    //super.initState();
  }

  void _addBikeMarker(double lat, double log, int id) async {
    // Falta BikeType com a argument
    final iconMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2,),
        "assets/images/punt_bicicleta.png");
    //print('afegir bici');
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
            scrolledup = true;
            _getBike(id);
          });
        } //_onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id.toString())] = marcador;
  }

  void removeMarkers() {
    Set<Marker> markersToRemove = {};
    markers = markersToRemove;
  }
  
  void _addMarker(double lat, double log, String chargerType, int id) async {
    final iconMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2,),
        "assets/images/punt_carregador.png");
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
            scrolledup = true;
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

  void _setCardView()  {
    _getCharger(widget.publicationId!);
    setState(() {
      widget.index = 0;
      id_marcador = widget.publicationId.toString();
      is_visible = true;
      scrolledup = true;
      loading_charger = true;

    });
  }
  void _setCardBikeView()  {
    _getBike(widget.publicationId!);
    setState(() {
      widget.index = 1;
      id_marcador = widget.publicationId.toString();
      is_visible = true;
      scrolledup = true;
      loading_bike = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!is_visible && widget.publicationId != -1 && widget.index == 0 ) {
      _setCardView();
    }
    if (!is_visible && widget.publicationId != -1 && widget.index != 0) {
      _setCardBikeView();
    }
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
                    'Tapped location LatLong is (${latLong.latitude},${latLong
                        .longitude})'),
              ));
            },
            onCameraMove: onCameraMove,
          ),
          is_visible ? show_card() : Container(),
        ],
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: scrolledup ? scrollDown() : scrollMiddle()
      )
    );
  }

List<Widget> scrollDown() {
  double width = MediaQuery.of(context).size.width;
  return <Widget>[
    Padding(
      padding: EdgeInsets.only(left: width * 0.83),
      child: listButton(),
    ),
    const SizedBox(height: 10),
    Padding(
      padding: EdgeInsets.only(left: width * 0.83),
      child: currentLocationActionButton(),
    ),
    const SizedBox(height: 200)];
}

Widget filterMap() {
  double height = MediaQuery.of(context).size.height;
  if (widget.index == 0) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.49),
      child: ChargerFilterMap(functionPublic: _getPublicChargers,
          functionPrivate: _getPrivateChargers, functionAll: _getChargers),
    );
  } else {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.49),
      child: BikeFilterMap(functionNormal: _getNormalBikes,
          functionElectric: _getElectricBikes, functionAll: _getBikes),
    );
  }
}

List<Widget> scrollMiddle() {
  double width = MediaQuery.of(context).size.width;
  return <Widget>[
    filterMap(),
    Padding(
      padding: EdgeInsets.only(left: width * 0.83),
      child: listButton(),
    ),
    const SizedBox(height: 10),
    Padding(
      padding: EdgeInsets.only(left: width * 0.83),
      child: currentLocationActionButton(),
    ),
  ];
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
    return SlidingUpPanel(
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.6,
        minHeight: 210.0,
        controller: panelController,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        backdropEnabled: true,
        onPanelSlide: (double pos) =>
            setState(() {
              if (pos < 0.2) {
                scrolledup = true;
              } else {
                scrolledup = false;
              }
            }),
        panelBuilder: (controller) =>
          _publicationloaded ? buildSlidingUpPanelCharger(
            controller: controller,
            panelController: panelController,
          ) : Container(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)));
  } else {
    return SlidingUpPanel(
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.8,
        minHeight: 185.0,
        controller: panelController,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        backdropEnabled: true,
        onPanelSlide: (double pos) =>
            setState(() {
              if (pos < 0.2) {
                scrolledup = true;
              } else {
                scrolledup = false;
              }
            }),
        panelBuilder: (controller) =>
          _publicationloaded ? buildSlidingUpPanelBike(
            controller: controller,
            panelController: panelController,
          ) : Container(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)));
  }
}

  void _showAvisNoEsPotCarregarCarregador() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charger Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load charger info'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void _getCharger(int id) async {
  DetailedCharherSerializer? charger = await ChargerService.getCharger(id);
  if (charger != null) {
    setState(() {
      //loading_charger = true;
      _publicationloaded = true;
      markedCharger = charger;
    });
  } else {
    _showAvisNoEsPotCarregarCarregador();
  }
}

Widget buildSlidingUpPanelCharger(
    {required ScrollController controller, required PanelController panelController}) {
  String? descrip = markedCharger!.title;
  descrip = title_parser(descrip);

  //Generación rate aleatoria (harcode rate) --> Quan estigui el sistema de rates
  Random random = Random();
  int min = 2,
      max = 6;
  int num = (min + random.nextInt(max - min));
  double numd = num.toDouble();

  //Obtencion del numero de tipos de cargadores
  List<ConnectionType> types = [];
  for (int i = 0; i < markedCharger!.connection_type.length; ++i) {
    types.add(markedCharger!.connection_type[i]);
  }

  bool private = markedCharger!.private != null ? true : false;
  double price = markedCharger!.private != null
      ? markedCharger!.private!.price
      : 0.0;
  String? direction = markedCharger!.direction;
  direction = title_parser(direction);
  String? description = markedCharger!.description;
  double latitude = markedCharger!.localization.latitude;
  double longitude = markedCharger!.localization.longitude;


  return CardInfoWidget(location: descrip,
      rating: numd,
      types: types,
      available: true,
      match: true,
      private: private,
      price: price,
      direction: direction,
      description: description,
      latitude: latitude,
      longitude: longitude,
      private_list: false);
}

  void _showAvisNoEsPotCarregarBici() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bike Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load bike info'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void _getBike(int id) async {
  DetailedBikeSerializer? bike = await BikeService.getBike(id);
  if (bike != null) {
    setState(() {
      _publicationloaded = true;
      widget.index = 1;
      markedBike = bike;
    });
  } else {
    _showAvisNoEsPotCarregarBici();
  }
}

Widget buildSlidingUpPanelBike(
    {required ScrollController controller, required PanelController panelController}) {
  String? descrip = markedBike!.title!;
  descrip = title_parser(descrip);

  //Generación rate aleatoria (harcode rate) --> Quan estigui el sistema de rates
  Random random = Random();
  int min = 2,
      max = 6;
  int num = (min + random.nextInt(max - min));
  double numd = num.toDouble();
  BikeType bikeType = markedBike?.bike_type as BikeType;
  String? direction = markedBike!.direction;
  direction = title_parser(direction);
  String? description = markedBike!.description;
  double price = markedBike!.price;
  double? power = markedBike!.power;

  print('power: $power');

  return BikeCardInfoWidget(location: descrip, rating: numd, available: true, type: bikeType, description: description, direction: direction, price: price, power: power??0, bike_list: false);
}

String? title_parser(String? description) {
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
  if (description!.length >= 40) {
    description = description.replaceAll(" - ", "\n");
    //description = description.replaceAll("-", "\n");
    description = description.replaceAll("- ", "\n");
    description = description.replaceAll(")(", ")\n(");
    description = description.replaceAll(" (", "\n(");
    description = description.replaceAll("E L'", "E\nL'");
  }
  if (description.length < 40) {
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
    ));}
