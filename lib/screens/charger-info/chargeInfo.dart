
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/screens/charger-info/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_route.dart';
import 'package:greenwheel/screens/charger-info/widgets/image_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/location_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/match_with_car.dart';
import 'package:greenwheel/screens/charger-info/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/screens/charger-info/widgets/stars_static_rate.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';



void main(){runApp(const MaterialApp(
  title: 'chargeInfo try',
  home: Scaffold(
    body: ChargeInfo(),
  ),
));}

class ChargeInfo extends StatefulWidget {
  const ChargeInfo({Key? key}) : super(key: key);

  @override
  State<ChargeInfo> createState() => _ChargeInfoState();

}
abstract class Marcador {
  late int id;
  late double latitude;
  late double longitude;
  late String direction;
  late double power;
  late String town;
}

class _ChargeInfoState extends State<ChargeInfo>{
  late GoogleMapController mapController;
  //Posem inicailment localiztzacio del user o barna?
  final LatLng _center = const LatLng(41.3874, 2.1686);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};
  Set<Marcador> marcadores = {};
  final Map<MarkerId, Marker> markerMap = {};
  bool is_visible = false;
  late String adress = "PLAÇA CAT";


  @override
  void initState(){
    _addMarker(41.3874, 2.1686, 0, "Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true);
    _addMarker(41.375182, 2.182867, 1, "Maremagnum", 5.0, 3,"10:00 - 20:00h", true);
    super.initState();
  }

  //funcion para añadir los marcadores al set
  void _addMarker(double lat, double log, int id, String address, double rate, int distance, String time, bool match) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 3.2,
          //size: Size(50, 50)
        ),
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
          is_visible = true;
        });
      });
    markers.add(marcador);
    Marcador? mark;
    mark!.id = id;
    mark.direction = address;
    mark.longitude = log;
    mark.latitude = lat;
    marcadores.add(mark);

  }

  /*//Cambio del marcador en el plano 2D-3D
  Future<void> _cambiarPlano(MarkerId markerId) async {
    final Marker marcador = markerMap[markerId]!;
    setState(() {
      markerMap[markerId] = marcador.copyWith(
        flatParam: !marcador.flat
      );
    });
  }*/

  Widget _buildCard(String location, double rating, int distance, String time, bool avaliable,  bool match) {
    return Card(
      elevation: 10,
      shape:  const RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff43802a),
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        height: 175,
        width: 400,
        child:Row(
          children: [
            SizedBox(
              width: 270,
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5, left: 25),
                    child: LocationChargerWidget(location: location),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child:  StarsStaticRateWidget(rate: 4.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child:  PointOfChargeDistWidget(distance: 2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: AvaliablePublicChargerWidget(avaliable: avaliable),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: MatchWithCarWidget(match: match),
                  ),
                ],
              ),
            ),
            Column(
              children:const [
                Padding(
                  padding:EdgeInsets.only(right: 12),
                  child: ImageChargerWidget(),
                ),
                Padding(
                  padding:EdgeInsets.only(left: 15),
                  child: ButtonRouteWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final tr = AppLocalizations.of(context)!;
    return  Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              //haura d'anar la ubi del marcador seleccionat
                target: _center,
                zoom: 11.0
            ),
            markers: markers,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onTap: onTap,
          ),
          is_visible ? infoWidget() : Container()
        ],
      ),
    );
  }

  infoWidget(){
    return Padding(
        padding: const EdgeInsets.only(top: 650),
        child: _buildCard(adress, 4, 2, "time", true, true)
    );
  }

  void onTap(LatLng pos){
    marcadores.forEach((element) {
      if (element.latitude == pos.latitude && element.longitude == pos.longitude){
        adress = element.direction;
      }
    });
    setState(() {
      is_visible = true;
    });
  }
}

