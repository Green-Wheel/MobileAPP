
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  //Map<String, String> markerMap = {};

  /*void _addToSetMarkers (Set<Marker> markers, Map<String, LatLng> positions){
    if (positions != null){
      for (int i = 0; i < positions.length; i++){
        _addMarker(positions[i]!.latitude, positions[i]!.longitude, positions.keys.toString());
      }
    }
  }*/

  void initState(){
    super.initState();
    _addMarker(41.3874, 2.1686, "plaça-cat", "Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true);
    _addMarker(41.375182, 2.182867, "maremagnum", "Maremagnum", 5.0, 3,"10:00 - 20:00h", true);
  }

  //funcion para añadir los marcadores al set y mostrarlos por pantalla
  void _addMarker(double lat, double log, String id, String address, double rate, int distance, String time, bool match) async{
    final icon_marker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 3.2,
          //size: Size(50, 50)
        ),
        "assets/images/punt_carregador.png");
    markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, log),
        onDrag: null,
        onDragStart: null,
        icon: icon_marker,
        //onTap: _buildCard(address,rate,distance,time,match),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //final tr = AppLocalizations.of(context)!;
    return  Scaffold(
      body: _buildCard("Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true)/*Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 150.0),
          children:[
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
              ),
           ],
          ),
        ),*/

        /*GoogleMap(
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
      ),*/
      );

  }

  Widget _buildCard(String location, double rating, int distance, String time, bool match) => Card(
      elevation: 20,
      color: CupertinoColors.extraLightBackgroundGray,
      shadowColor: Colors.black,
      //margin: EdgeInsets.only(left: 15.0, bottom: 90.0),
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
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 3.0, top: 15.0) ,
                child: Row(
                  children: [
                     Text(location,
                        style: TextStyle(fontWeight: FontWeight.w600)
                    ),
                    Icon(
                      Icons.bolt,
                      size: 20,
                      color: Colors.green[500],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 3.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[500],
                    ),
                     Padding(
                        padding:EdgeInsets.only(left: 10.0),
                        child: Text(rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                    ),
                  ],
                ),
              )
            ),
            Container(
              child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 3.5),
                  child: Row(
                    children: [
                      Text('Point of charge - ($distance km)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 4.0),
                child: Row(
                  children:[
                    const Text('Available: ',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                    Text(time,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: const [
                    Icon (
                      Icons.check_circle_outline_rounded,
                      size: 20,
                      color: Colors.green,
                    ),
                    Padding(
                      padding:EdgeInsets.only(left: 5.0),
                      child: Text('Matching with your car charger',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0,),
                child: Row(
                  children: [
                    Column(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueAccent, // foreground
                            ),
                            onPressed:() {},
                            child: Row(
                              children: const [
                                Text('Route ',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                                ),
                                 Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 20,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                        ),
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
            ),
          ],
        ),
      ),
  );

}