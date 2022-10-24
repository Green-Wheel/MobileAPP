
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

class _ChargeInfoState extends State<ChargeInfo>{
  late GoogleMapController mapController;

  //Posem inicailment localiztzacio del user o barna?
  final LatLng _center = const LatLng(41.3874, 2.1686);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};
  final Map<MarkerId, Marker> markerMap = {};
  late Marker actualMarcador;

  @override
  void initState(){
    _addMarker(41.3874, 2.1686, "plaça-cat", "Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true);
    _addMarker(41.375182, 2.182867, "maremagnum", "Maremagnum", 5.0, 3,"10:00 - 20:00h", true);
    super.initState();
  }

  //funcion para añadir los marcadores al set
  void _addMarker(double lat, double log, String id, String address, double rate, int distance, String time, bool match) async{
    final iconMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 3.2,
          //size: Size(50, 50)
        ),
        "assets/images/punt_carregador.png");
    final Marker marcador = Marker(
      markerId: MarkerId(id),
      position: LatLng(lat, log),
      onDrag: null,
      icon: iconMarker,
      onTap: () => _onMarkerTapped(MarkerId(id)),
    );
    markers.add(marcador);
    markerMap[MarkerId(id)] = marcador;
  }

  //Seleccionar marcador i devolver el id para obtener datos  futuro
  _onMarkerTapped(MarkerId markerId) async {
    final Marker? markerTapped = markerMap[markerId];
    if (markerTapped != null && markerMap.containsKey(markerId)) {
      actualMarcador = markerTapped;
      _buildCard("maremagnum", 4, 3, "10:00 - 14:00h", true, true);
      /*await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: markerMap[markerId]!.position,
            zoom: 17,
          )
        )
      );*/
    }
  }


  //Cambio del marcador en el plano 2D-3D
  Future<void> _cambiarPlano(MarkerId markerId) async {
    final Marker marcador = markerMap[markerId]!;
    setState(() {
      markerMap[markerId] = marcador.copyWith(
        flatParam: !marcador.flat
      );
    });
  }

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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 135),
                  child: LocationChargerWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 65),
                  child:  StarsStaticRateWidget(rate: 4.0),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 55),
                  child:  PointOfChargeDistWidget(distance: 2),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 83),
                  child: AvaliablePublicChargerWidget(avaliable: avaliable),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: MatchWithCarWidget(match: match),
                ),
              ],
            ),
            Column(
              children:const [
                Padding(
                  padding:EdgeInsets.only(left: 8),
                  child: ImageChargerWidget(),
                ),
                Padding(
                  padding:EdgeInsets.only(left: 5),
                  child: ButtonRouteWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
      //elevation: 20,
     /* color: CupertinoColors.extraLightBackgroundGray,
      shadowColor: Colors.black,
      shape:  const RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff43802a),
          width: 4,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        height: 175,
        width: 400,
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.0,),
                  child: LocationChargerWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,),
                  child: StarsStaticRateWidget(rate: 3.5),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,),
                  child: PointOfChargeDistWidget(distance: distance),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 83.0),
                  child: AvaliablePublicChargerWidget(avaliable: avaliable),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: MatchWithCarWidget(match: match),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          ButtonRouteWidget(),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueAccent, // foreground
                            ),
                            onPressed:() {},
                            child: Row(
                              children: const [
                                Text('Chat ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                                ),
                                Icon(
                                  Icons.chat_outlined,
                                  size: 20,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
  );*/

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
            //onTap: ,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 550, 0, 0),
              child: _buildCard("Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true, true)
          ),
        ],
      ),
    );
  }
  /*_zoomIn() async{
    await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
              target: ,
              zoom: 17,
            )
        )
    );
  }*/
}

