import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/user_service.dart';
import 'package:greenwheel/services/generalServices/LoginService.dart';
import 'package:greenwheel/widgets/button_blue_route.dart';
import 'package:greenwheel/widgets/button_delete_bike.dart';
import 'package:greenwheel/widgets/button_reserva_list.dart';
import 'package:greenwheel/widgets/button_route.dart';
import 'package:greenwheel/widgets/chat_button.dart';
import 'package:greenwheel/widgets/image_bike.dart';
import 'package:greenwheel/widgets/location_bike.dart';
import 'package:greenwheel/widgets/point_of_charge_dist.dart';
import 'package:greenwheel/widgets/stars_static_rate.dart';

import '../serializers/bikes.dart';
import 'available_bike.dart';
import 'button_reserva_list_bike.dart';
import 'image_display.dart';

class BikeCardInfoWidget extends StatefulWidget {
  String? location;
  double? rating;
  bool available;
  BikeType type;
  double price;
  String? description;
  String? direction;
  double power;
  bool bike_list;
  double latitude;
  double longitude;
  int? id;
  int? owner_id;
  String? contamination;
  List? images;

  BikeCardInfoWidget(
      {required this.location,
      required this.rating,
      required this.available,
      required this.type,
      required this.price,
      required this.description,
      required this.direction,
      required this.power,
      required this.bike_list,
      required this.latitude,
      required this.longitude,
      required this.id,
      required this.owner_id,
      required this.contamination,
      required this.images,
      super.key});

  @override
  State<StatefulWidget> createState() => _BikeCardInfoWidget();
}

class _BikeCardInfoWidget extends State<BikeCardInfoWidget> {
  final _loggedInStateInfo = LoginService();
  var userData;
  bool mybike = true;
  String username = "";

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    var data = LoginService().user_info;
    var user = await UserService.getUser(widget.owner_id!);
    setState(() {
      userData = data;
      mybike = userData['id'] == widget.owner_id;
      username = user?.username ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(
        widget.location,
        widget.rating,
        widget.available,
        widget.type,
        widget.price,
        widget.description,
        widget.direction,
        widget.power,
        widget.bike_list,
        widget.latitude,
        widget.longitude,
        widget.id,
        context,
        mybike,
        widget.owner_id,
        username,
        widget.contamination,
        widget.images);
  }
}

Widget ratingButton(BuildContext context,int publication_id){
  return  SizedBox(
    height: 33,
    width: 160,
    child: TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<
              Color>(Colors.lightBlue[50]!),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      18.0),
                  side: const BorderSide(
                      color: Colors.lightBlueAccent)
              )
          )
      ),
      onPressed: () {
        GoRouter.of(context).push('/ratings/publications/$publication_id');

      },
      child: Row(
        children: const [
          Icon(
            Icons.stars,
            size: 18,
            color: Colors.lightBlueAccent,
          ),
          SizedBox(width: 5),
          Text('Publication rating ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.lightBlueAccent),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCard(
    String? location,
    double? rating,
    bool available,
    BikeType type,
    double price,
    String? description,
    String? direction,
    double power,
    bool bike_list,
    double latitude,
    double longitude,
    int? id,
    BuildContext context,
    bool mybike,
    int? owner_id,
    String? username,
    String? contamination,
    List? images) {
  return Card(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.725,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5, left: 25),
                child:
                    LocationBikeWidget(location: location!, bikeType: type.id),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: rating != null
                    ? StarsStaticRateWidget(rate: rating)
                    : StarsStaticRateWidget(rate: 0.0),
              ),
              SizedBox(height: 5),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.725,
                  child: type.name == "Electric"
                      ? Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: !bike_list
                              ? Text('Electric: $power W',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green))
                              : Text('Electric',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green)))
                      : Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: const Text('Manual',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amberAccent)),
                        )),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: AvaliableBikeWidget(avaliable: available),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Text(
                        "Price: ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        price.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      const Text(
                        " €/h",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 24, top: 5),
                child: Row(
                  children: [
                    if (contamination == null)
                      Icon(Icons.cloud_circle_outlined, color: Colors.grey),
                    if (contamination == "green")
                      Icon(Icons.cloud_circle_outlined, color: Colors.green),
                    if (contamination == "yellow")
                      Icon(Icons.cloud_circle_outlined, color: Colors.yellow),
                    if (contamination == "red")
                      Icon(Icons.cloud_circle_outlined, color: Colors.red),
                    if (contamination == "maroon")
                      Icon(Icons.cloud_circle_outlined, color: Colors.brown),
                    if (contamination == "orange")
                      Icon(Icons.cloud_circle_outlined, color: Colors.orange),
                    SizedBox(width: 2),
                    Text("Contamination",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              !bike_list ? SizedBox(height: 65): SizedBox(height: 0),
              !bike_list ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.925,
                  child: Flexible(
                      child: Column(
                          children:[
                            !bike_list? ButtonReservaListBikeWidget(id: id): SizedBox(height: 0),
                            !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                            !bike_list? SizedBox(height: 10): SizedBox(height: 0),
                            !bike_list? Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                  Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.5, bottom: 10),
                                    child:CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.lightBlue[100],
                                        child: Icon(Icons.location_on, color: Colors.blue, size: 30,)
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.925,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 25),
                                        child: direction != null ?
                                        Text("Address:  $direction",style: const TextStyle(fontWeight: FontWeight.w600)):
                                        Text("Address: No address available ",style: const TextStyle(fontWeight: FontWeight.w600))
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.925,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: description != null ?  Text("Description:  $description",
                                          style: const TextStyle(fontWeight: FontWeight.w600)
                                      ):  const Text("Description:  No description",
                                          style: TextStyle(fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ]): SizedBox(height: 0),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            Padding (
                              padding: EdgeInsets.only(left: 25),
                              child: InkWell(
                                  onTap: () {
                                    GoRouter.of(context).go('/profile/$owner_id');
                                  },
                                  child: Row(
                                      children:[
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.lightBlue[100],
                                          child: Icon(
                                              color: Colors.blue,
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
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                            Row(
                              children: [
                                !mybike ? Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child:ChatButtonWidget(to_user: owner_id),
                                ): SizedBox(height: 0),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 5),
                                  child: ratingButton(context,id!),
                                ),
                                //!mybike? SizedBox(width:MediaQuery.of(context).size.width * 0.05) : SizedBox(width: 0),
                                //mybike ? ButtonDeleteBikeWidget(id_bike: id) : SizedBox(height: 0)
                              ],
                            ),
                          ]
                      )
                  )
              ) : SizedBox(height: 0),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.215,
          child: Column(
            children: [
              images?.length != 0 && !bike_list
                  ? ImageDisplay(
                      images:
                          images?.map((value) => value.image_path).toList() ??
                              [])
                  : const ImageBikeWidget(),
              SizedBox(height: 10),
              ButtonBlueRouteWidget(latitude: latitude, longitude: longitude),
              SizedBox(height: 20),
            ],
          ),
        )
      ],
    ),
  );
}
