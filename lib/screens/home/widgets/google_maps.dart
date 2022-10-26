import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsWidget extends StatefulWidget {
  Set<Polyline>? polylines = {};

  GoogleMapsWidget({Key? key, this.polylines}) : super(key: key);


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
  late Marker actualMarcador;
  List markersList = [];

  void _getAndDrawPublicChargers() async {
    BackendService.get('chargers/public/').then((response) {
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          markersList = jsonResponse;
          for (int i = 0; i < markersList.length; i++) {
            Map localization = markersList[i]['localization'];
            double latitude = localization['latitude'];
            double longitude = localization['longitude'];
            if (markersList[i]['direction'] == null) {
              markersList[i]['direction'] = "No description";
            }
            _addMarker(latitude, longitude, markersList[i]['description'], markersList[i]['direction'], 5.0, 2, "10:00 - 20:00h");
          }
        });
      } else {
        print('Error getting chargers!');
      }
    });
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
    _getAndDrawPublicChargers();
    super.initState();
  }

  void _addMarker(double lat, double log, String id, String address, double rate, int distance, String time) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.2,), "assets/images/punt_carregador.png");
    final Marker marcador = Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, log),
        onDrag: null,
        icon: iconMarker,
        onTap: () {} //_onMarkerTapped(MarkerId(id)),
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
    //debugPrint('$cameraPosition');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _kInitialPosition,
        markers: markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        trafficEnabled: widget.polylines != null ? false : true,
        mapToolbarEnabled: false,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        liteModeEnabled: false,
        polylines: widget.polylines != null ? widget.polylines! : {},
        onTap: (latLong) {
          (SnackBar(
            content: Text(
                'Tapped location LatLong is (${latLong.latitude},${latLong.longitude})'),
          ));
        },
        onCameraMove: onCameraMove,
      ),
      floatingActionButton: currentLocationActionButton(),
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
