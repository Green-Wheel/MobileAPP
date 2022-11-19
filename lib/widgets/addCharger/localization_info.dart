import 'package:flutter/material.dart';
import 'package:greenwheel/utils/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../serializers/maps.dart';
import 'package:searchfield/searchfield.dart';

import '../../utils/address_autocompletation.dart';
import '../location_search.dart';

class LocalizationInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  LocalizationInfo(
      {Key? key,
      required this.data,
      required this.callback,
      required this.nextPage,
      required this.prevPage})
      : super(key: key);

  @override
  State<LocalizationInfo> createState() => _LocalizationInfoState();
}

class _LocalizationInfoState extends State<LocalizationInfo> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  Address _selectedAddress = Address(
      street: '',
      streetNumber: '',
      city: '',
      postalCode: '',
      province: '',
      country: '');



  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(41.7285833, 1.8130899),
    zoom: 8.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void submitSearch(value) async {
    LatLang? prov = await Geocoding.getLatLangFromAddress(value);
    _selectedAddress = (await Geocoding.getAddressFromLatLang(prov!))!;
    setState(() {
      selectPoint(LatLng(prov!.lat, prov.lng));
    });
  }

  void selectPoint(LatLng point) async {
    LatLang p = LatLang(lat: point.latitude, lng: point.longitude);
    //Address? addres = await Geocoding.getAddressFromLatLang(p);
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
      ));
      //_selectedAddress = addres!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localization'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 1 * MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  LocationSearch(
                    submitSearch: submitSearch,
                  ),
                  Text('Street: ${_selectedAddress.street ?? ''}'),
                  Text('Street Number: ${_selectedAddress.streetNumber ?? ''}'),
                  Text('City: ${_selectedAddress.city ?? ''}'),
                  Text('Postal Code: ${_selectedAddress.postalCode ?? ''}'),
                  Text('Province: ${_selectedAddress.province ?? ''}'),
                  Text('Country: ${_selectedAddress.country ?? ''}'),
                  Text(
                      'lat: ${_markers.isNotEmpty ? _markers.first.position.latitude : ''}'),
                  Text(
                      'lng: ${_markers.isNotEmpty ? _markers.first.position.longitude : ''}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _kInitialPosition,
                markers: _markers,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: false,
                mapToolbarEnabled: false,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                liteModeEnabled: false,
                onTap: (point) => selectPoint(point),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
