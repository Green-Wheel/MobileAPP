import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/avaliable_public_charger.dart';
import 'package:greenwheel/widgets/button_delete_charger.dart';
import 'package:greenwheel/widgets/button_reserva_list.dart';
import 'package:greenwheel/widgets/button_route.dart';
import 'package:greenwheel/widgets/chat_button.dart';
import 'package:greenwheel/widgets/image_charger.dart';
import 'package:greenwheel/widgets/location_charger.dart';
import 'package:greenwheel/widgets/match_with_car.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

import '../serializers/chargers.dart';
import '../services/generalServices/LoginService.dart';
import 'image_display.dart';

class CardInfoWidget extends StatefulWidget {
  String? location;
  double? rating;
  List<ConnectionType> types;
  bool available;
  bool? match;
  bool private;
  double price;
  String? description;
  String? direction;
  bool private_list;
  double latitude;
  double longitude;
  int? id;
  int? owner_id;
  String? owner_username;
  String? contamination;
  List? images;

  CardInfoWidget({required this.location, required this.rating, required this.types, required this.available,
    required this.match, required this.private, required this.price, required this.description, required
  this.direction, required this.private_list, required this.latitude, required this.longitude, required this.id,
    required this.owner_id, required this.owner_username, required this.contamination, required this.images, super.key});

  @override
  State<StatefulWidget> createState() => _CardInfoWidget();
}

class _CardInfoWidget extends State<CardInfoWidget>{
  var userData;
  late bool isOwner;

  @override
  void initState() {
    super.initState();
  }
  void _getData() {
    var data = LoginService().user_info;
    setState(() {
      userData = data;
      isOwner = userData['id'] == widget.owner_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    int? owner_id = widget.owner_id!;
    return _buildCard(widget.location, widget.rating, widget.types, widget.available, widget.match, widget.private, widget.price,
        widget.description, widget.direction, widget.private_list, widget.latitude, widget.longitude, widget.id, isOwner, owner_id,
        widget.owner_username, widget.contamination, widget.images, context);
  }
}

Widget _buildCard(String? location, double? rating, List<ConnectionType> types, bool avaliable, bool? match, bool private, double price,
    String? description, String? direction, bool private_list, double latitude, double longitude, int? id,
    bool isOwner, int? owner_id, String? username, String? contamination, List? images, BuildContext context) {

  return Card(
    elevation: 10,
    shape:  const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.725,
            child:Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 25),
                  child: LocationChargerWidget(location: location),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: rating != null ?
                  StarsStaticRateWidget(rate: rating) :
                  StarsStaticRateWidget(rate: 0.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: PointOfChargeDistWidget(types: types),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.725,
                  child: private ?
                      Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: const Text('Private',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent))
                          ,
                        )
                      : Padding(
                            padding: EdgeInsets.only(left: 27),
                            child: const Text('Public',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),
                        )
                  ),
                /*Padding(
                  padding: const EdgeInsets.only(right: 193),
                  child: private_list ? const Text('Private',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amberAccent)
                  ) : SizedBox()),*/
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: AvaliablePublicChargerWidget(avaliable: avaliable),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: MatchWithCarWidget(match: match!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 5),
                  child: Row(
                    children: [
                      if(contamination == null ) Icon(Icons.cloud_circle_outlined, color: Colors.grey),
                      if(contamination == "green") Icon(Icons.cloud_circle_outlined, color: Colors.green),
                      if(contamination == "yellow") Icon(Icons.cloud_circle_outlined, color: Colors.yellow),
                      if(contamination == "red") Icon(Icons.cloud_circle_outlined, color: Colors.red),
                      if(contamination == "maroon") Icon(Icons.cloud_circle_outlined, color: Colors.brown),
                      if(contamination == "orange") Icon(Icons.cloud_circle_outlined, color: Colors.orange),
                      SizedBox(width: 2),
                      Text("Contamination",
                      style: TextStyle( color: Colors.black)),

                    ],
                  ),
                ),
                private && !private_list? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.925,
                  child: Flexible(
                    child:Column(
                    children: [
                      private? SizedBox(height: 10): SizedBox(height: 0),
                      private? SizedBox(height: 60) : SizedBox(height: 0),
                      private? ButtonReservaListWidget(id: id) : SizedBox(height: 0),
                      private? SizedBox(height: MediaQuery.of(context).size.height * 0.03):  SizedBox(height: 0),

                    private? Padding (
                      padding: EdgeInsets.only(left: 25, bottom: 10),
                      child: Row(
                          children:[
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.lightGreen[100],
                              child: Icon(
                                  color: Colors.green,
                                  Icons.euro_symbol,
                                  size: 30
                              ),
                            ),
                          ],
                        ),
                       ): SizedBox(height: 0),
                      private? Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:Row(
                            children: [
                                Text("Price: ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(price.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              const Text(" €/KWh",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                      ): SizedBox(height: 0),
                      private? SizedBox(height: MediaQuery.of(context).size.height * 0.03): SizedBox(height: 0),
                      private? Column(
                        children: [
                          Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.5, bottom: 10),
                            child:CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.lightGreen[100],
                              child: Icon(Icons.location_on, color: Colors.green, size: 30,)
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.925,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: direction != null ? Text("Address:  $direction",
                                  style: const TextStyle(fontWeight: FontWeight.w600)
                              ):  const Text("Address:  No address available",
                                  style: TextStyle(fontWeight: FontWeight.w600)
                              )
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.925,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: description != null ? Text("Description:  $description",
                                    style: const TextStyle(fontWeight: FontWeight.w600)
                                ):  const Text("Description:  No description",
                                    style: TextStyle(fontWeight: FontWeight.w600)
                                ),
                              ),
                          )
                        ]): SizedBox(height: 0),
                      private? SizedBox(height: MediaQuery.of(context).size.height * 0.03):SizedBox(height: 0),
                      private? Padding (
                        padding: EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: () {
                            //TODO: Ruta user perfil
                          },
                          child: Row(
                              children:[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.lightGreen[100],
                                  child: Icon(
                                      color: Colors.green,
                                      Icons.person,
                                      size: 30
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("$username",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ]
                          )
                        ),
                      ): SizedBox(height: 0),
                      private? SizedBox(height: MediaQuery.of(context).size.height * 0.02):SizedBox(height: 0),
                      private?  Row(
                        children: [
                          !isOwner ? Padding(padding: EdgeInsets.only(left: 25, right: 20),
                            child: ChatButtonWidget(to_user: owner_id!),
                          ): Container(),
                          //!isOwner ? Padding(padding: EdgeInsets.only(left: 25),
                              //child: ButtonDeleteChargerWidget(id_charger: id!)): SizedBox(height: 0),
                        ],
                      ) : SizedBox(height: 0),
                    ],
                  ),
                )
                ): SizedBox(height: 0),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.215,
            child: Column(
              children:  [
                  SizedBox(height: 30),
                  ImageDisplay(images: images ?? []),
                  SizedBox(height: 10),
                  ButtonRouteWidget(latitude: latitude, longitude: longitude),
                  private? SizedBox(height: MediaQuery.of(context).size.height * 0.315): SizedBox(height: 35),
              ],
            ),
          ),
        ],
    ),
  );
}
