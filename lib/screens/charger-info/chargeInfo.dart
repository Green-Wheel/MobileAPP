
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/charger-info/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_list_screen_chargers.dart';
import 'package:greenwheel/screens/charger-info/widgets/button_route.dart';
import 'package:greenwheel/screens/charger-info/widgets/card_info.dart';
import 'package:greenwheel/screens/charger-info/widgets/image_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/location_charger.dart';
import 'package:greenwheel/screens/charger-info/widgets/match_with_car.dart';
import 'package:greenwheel/screens/charger-info/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/screens/charger-info/widgets/stars_static_rate.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../widgets/interactive_stars_widget.dart';
import '../home/widgets/bottom_bar.dart';
import '../home/widgets/drawer.dart';
import '../home/widgets/google_maps.dart';



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

class Marcador {

  int id;
  double latitude;
  double longitude;
  String direction;
  double power;
  String town;

  Marcador(this.id, this.latitude, this.longitude, this.direction, this.power, this.town);
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
  LatLng pos = LatLng(41.3874, 2.1686);
  final panelController = PanelController();

  @override
  void initState() {
    _addMarker(
        41.3874, 2.1686, 0, "Plaça Catalunya", 5.0, 2, "10:00 - 20:00h", true);
    _addMarker(
        41.375182, 2.182867, 1, "Maremagnum", 5.0, 3, "10:00 - 20:00h", true);
    super.initState();
  }

  Widget buildCard(String location, double rating, int distance, String time, bool avaliable,  bool match) {
    return Card(
      elevation: 10,
      shape:  const RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff43802a),
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
          child:Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.725,
                child:Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5, left: 25),
                      child: LocationChargerWidget(location: location),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child:   InteractiveStarsWidget(rate: 0.0),//StarsStaticRateWidget(rate: 4.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child:  PointOfChargeDistWidget(types: 2),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.215,
                child: Column(
                  children:const [
                    ImageChargerWidget(),
                    ButtonRouteWidget(latitude: 41.3874, longitude: 2.1686),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
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

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(41.7285833, 1.8130899),
    zoom: 8.0,
  );

  void onCameraMove(CameraPosition cameraPosition) {
    //print('$cameraPosition');
  }

  @override
  Widget build(BuildContext context) {
    //final tr = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar: AppBar(title: Text("PROBA"), actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {});
            })
      ]),
      body:Scaffold(
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
              is_visible? SlidingUpPanel(
                // https://www.youtube.com/watch?v=s9XHOQeIeZg&ab_channel=JohannesMilke
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                minHeight: 175.0,
                controller: panelController,
                parallaxEnabled: true,
                parallaxOffset: 0.5,
                backdropEnabled: true,
                panelBuilder: (controller) => buildSlidingUpPanel(
                  controller: controller,
                  panelController: panelController,
                ), borderRadius: BorderRadius.vertical(top: Radius.circular(18))) : Container(),
              //!!!!!!is_visible ? show_card() : Container()
            ],
          ),
          /*floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonListScreenChargersWidget(),
              SizedBox(height: 10),
            ],
          ),*/
        ),
          //is_visible ? InteractiveStarsWidget(rate: 0.0) : Container(),
      bottomNavigationBar: BottomBarWidget(
        index: 1,
        onChangedTab: (index) {
          setState(() {});
        },
      ),
      drawer: SimpleDrawer(),
      floatingActionButton: const BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget show_card(){
    return Expanded(
      child: buildCard("bcn", 5, 2, "time", true, true)
    );
    return CardInfoWidget(location: "BCN", rating: 5, types: 5, avaliable: true, match: true);
  }


  infoWidget(LatLng pos) {
    return Padding(
        padding: const EdgeInsets.only(top: 650),
        child: buildCard(adress, 4, 2, "time", true, true));
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

  Widget buildSlidingUpPanel({required ScrollController controller, required PanelController panelController}) {
    return buildCard("bcn", 5, 2, "time", true, true);
    return CardInfoWidget(location: "BCN", rating: 5, types: 5, avaliable: true, match: true);
  }
}



