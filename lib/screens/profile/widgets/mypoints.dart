import 'package:flutter/material.dart';

import '../../../serializers/chargers.dart';
import '../../../services/backendServices/user_service.dart';
import '../../bookings/bookings.dart';

class MyPoints extends StatefulWidget {
  MyPoints(value, {Key? key}) : value = value, super(key: key);
  int value;
  @override
  State<MyPoints> createState() => MyPointsState();
}

class MyPointsState extends State<MyPoints> {
  List<Publication> publications = [];

  @override
  void initState() {
    super.initState();
    //_getRatings();
    _getPublications();
  }

  void _getPublications() async {
    List<Publication> publicationlist = await UserService.getPostsUser(widget.value);
    if (publicationlist.isEmpty) {
      print("BBBBBBBBBBBB");
    }
    else print("publication: $publicationlist");
    setState(() {
      publications = publicationlist;
      //obtenir ratings
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:0,left:20,right:20),
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height/20,
      child: Row(
        children: <Widget> [
          Text("My Points",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ElevatedButton(onPressed: (){
            print(publications[0]);
          },
          child: Text("")),

          //buildList(publications),

        ],
      )
    );
  }
  Widget buildList(List<Publication> publication) => ListView.builder(
    itemCount: publication.length,
    itemBuilder: (context, index) {
      double? rate = publication[index].charger?.avg_rating;
      if (publication[index].type == "Charger") {
        return Text("");
        //return ReservationChargerCard(booking: bookings[index], rating: rate);
      } else {
        return Text("");
        //  return ReservationBikeCard(booking: bookings[index], rating: rate);
      }
    }
  );
}
