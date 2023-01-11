import "package:flutter/material.dart";

import '../../services/backendServices/user_service.dart';

class TrophiesScreen extends StatefulWidget{
  TrophiesScreen(id,  {Key? key}) : id = id ,super(key: key);
  int id;
  @override
  State<TrophiesScreen> createState() => _TrophiesScreen();
}

class _TrophiesScreen extends State<TrophiesScreen>{

  final List<int> _listData = List<int>.generate(4, (i) => i);
  final List<Image> _list_images_trophys = [
    Image(width: 100,height:100,image: AssetImage('assets/images/added_one_electric_vehicle.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/added_multiple_electric_vehicle.jpg')),
    Image(width: 100,height:100,image: AssetImage('assets/images/added_one_bike.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/added_multiple_bikes.jpg')),
    Image(width: 100,height:100,image: AssetImage('assets/images/added_one_electric_charger.jpg')),
    Image(width: 100,height:100,image: AssetImage('assets/images/added_multiple_electric_chargers.jpg')),
    Image(width: 100,height:100,image: AssetImage('assets/images/booked_one.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/multiple_bookings.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/booked_ten.jpg')),
    Image(width: 100,height:100,image: AssetImage('assets/images/you_have_chatted.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/edited_user.png')),
    Image(width: 100,height:100,image: AssetImage('assets/images/registered.png'))
  ];
  final List<String> image_descritpor=[
    "First vehicle publicated",
    "Multiple vehicles publicated",
    "First bike publicated",
    "Multiple bikes publicated",
    "First charger publication",
    "Multiple chargers publications",
    "First booking",
    "Five bookings",
    "Ten bookings",
    "First chat message",
    "Edit profile",
    "First registration"
  ];
  List trophies_call = [];
  void initState() {
    super.initState();
    _getData();

  }
  var userData;
  int count = 0;
  void _getData() async {
    Map<String, dynamic> data = await UserService.getUserMap(widget.id) as Map<String,dynamic>;
    setState(() {
      userData = data;
    });
  }
  bool x = false;
  @override
  Widget build(BuildContext context) {
    if(!x && userData?["trophies"] != null){
      int aux = 0;
      trophies_call = userData?["trophies"];
      for(int i=0;i<trophies_call.length;++i) {
        if(trophies_call[i]['achieved']==true) ++aux;
      }
      count = aux;
      print(trophies_call);
      print("FIUMMMMMMMMMMM");
      x = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trophies'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _list_images_trophys.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) => i == 0
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:   Text("Achievements",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Image.asset(
                    'assets/images/trophies.jpg',
                    height: (MediaQuery.of(context).size.height)/6,
                    width: (MediaQuery.of(context).size.height)/3
                ),
              ),
              Center(
                child: Text("$count/12",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.indigo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("List of Achievements",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ],
          )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _list_images_trophys[i-1],
                      SizedBox(
                        width: 5,
                      ), // the space between image and text
                      Text(image_descritpor[i-1]),
                      Checkbox(
                        value: trophies_call.length > 0? trophies_call[i-1]['achieved'] : true,
                        onChanged: null
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    }
}