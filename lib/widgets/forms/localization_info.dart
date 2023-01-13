import 'package:flutter/material.dart';
import 'package:greenwheel/utils/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../serializers/maps.dart';
import '../location_search.dart';

class LocalizationInfo extends StatefulWidget {
  var addres;
  var localization;
  final Function callback;
  final Function nextPage;
  final Function prevPage;

  LocalizationInfo(
      {Key? key,
      required this.addres,
      required this.localization,
      required this.callback,
      required this.nextPage,
      required this.prevPage})
      : super(key: key);

  @override
  State<LocalizationInfo> createState() => _LocalizationInfoState();
}

class _LocalizationInfoState extends State<LocalizationInfo> {
  late GoogleMapController mapController;

  Address _selectedAddress = Address(
      street: '',
      streetNumber: '',
      city: '',
      postalCode: '',
      province: '',
      country: '',
  );

  Set<Marker> _markers = {};

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(41.7285833, 1.8130899),
    zoom: 8.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void submitAddress(value) async {
    LatLang? prov = await Geocoding.getLatLangFromAddress(value);
    Address? address = await Geocoding.getAddressFromLatLang(prov!);

    setPointAddress(prov, address!);
  }
  //TODO: add direction to the search bar
  void submitPoint(LatLng point) async {
    LatLang p = LatLang(lat: point.latitude, lng: point.longitude);
    Address? address = await Geocoding.getAddressFromLatLang(p);

    setPointAddress(p, address!);
  }

  void setPointAddress(LatLang point, Address address) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: LatLng(point.lat, point.lng),
      ));
      _selectedAddress = address;
      widget.localization = point;
      widget.addres =
          '${address.street}, ${address.streetNumber}, ${address.postalCode}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    submitSearch: submitAddress,
                    address: widget.addres,
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
                  Center(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.prevPage();
                          },
                          child: const Text('Previous'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            widget.callback(widget.localization, _selectedAddress);
                            widget.nextPage();
                          },
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
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
                onTap: (point) => submitPoint(point),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
