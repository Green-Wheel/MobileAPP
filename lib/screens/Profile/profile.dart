import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'point.dart';

import '../../services/backend_service.dart';

void main() {runApp(MaterialApp(
  title: 'profile',
  theme: ThemeData(
    scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
  ),
  home: Scaffold(
    appBar: AppBar(
      title: const Text('Perfil'),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 150.0),
          child: Icon(Icons.person),
        ),
      ],
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
        },
      ),
    ),
    body: Column(
        children: const [
          //MyProfile(),
          MyPoints()


        ]
    )
      
  ),
));}

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/profile-picture.png"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Daniel Oliveras",
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: const [
                              Text("4,5"),
                              Icon(Icons.star, color: Colors.amber,),
                              Icon(Icons.star, color: Colors.amber,),
                              Icon(Icons.star, color: Colors.amber,),
                              Icon(Icons.star, color: Colors.amber,),
                              Icon(Icons.star_half, color: Colors.amber,),

                            ],
                          ),
                          const Text("lvl 10 | 10.846 puntos",
                              style: TextStyle(color: Colors.green)
                          ),
                          Row(
                            children: [
                              const Text("Trofeos · "),
                              Row(
                                children: const [
                                  Icon(Icons.military_tech, color: Colors.purple,),
                                  Icon(Icons.military_tech, color: Colors.blue,),
                                  Icon(Icons.military_tech, color: Colors.red,),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.edit, color: Colors.blueAccent))
                    ],
                  ),

                ],
              ),
              Divider(thickness: 1, color: Colors.green[100], height: 40,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Sobre mí",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                  Text("Aficionado a los rallies de coches eléctricos y ganador del tour de francia con una bicicleta de Green Wheel.")
                ],
              ),
              Divider(thickness: 1, color: Colors.green[100], height: 40,)
            ]
        )
    );
  }
}


class MyPoints extends StatefulWidget {
  const MyPoints({Key? key}) : super(key: key);

  @override
  State<MyPoints> createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  List ebikes = [];
  List bikes = [];
  List chargers = [];
  List ratings = [];

  @override
  void initState() {
    super.initState();
    _getChargers();
    _getRatings();
    _getBikes();
    _getEbikes();
  }
//TODO: refactorizar los gets en una función que reciba por parámetro que se pide al backend
  void _getRatings() async {
    BackendService.get('ratings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          ratings = jsonResponse;
        });
      } else {
        Exception('Error getting ratings!');
      }
    });
  }

  void _getChargers() async {
    BackendService.get('chargers/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          chargers = jsonResponse;
        });
      } else {
        Exception('Error getting chargers!');
      }
    });
  }

  void _getBikes() async {
    BackendService.get('bikes/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          bikes = jsonResponse;
        });
      } else {
        Exception('Error getting bikes!');
      }
    });
  }

  void _getEbikes() async {
    BackendService.get('bikes/ebikes').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          ebikes = jsonResponse;
        });
      } else {
        Exception('Error getting ebikes!');
      }
    });
  }

//TODO: creo que se podría separa la parte estática en otro widget
  Widget _buildCard(Point point) => Card(
    elevation: 2,
    color: CupertinoColors.white,
    shadowColor: Colors.black,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: SizedBox(
      height: (point.type=="Bike") ? 165 : 185,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 3.0, top: 15.0) ,
            child: Row(
              children: [
                Text(
                    '${point.name} ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                ),
                if (point.type=="Charger")...[
                Icon(
                  Icons.bolt,
                  size: 25,
                  color: Colors.green[500],
                ),
                ]
                else if (point.type=="Bike")...[
                  Icon(
                  Icons.directions_bike,
                  size: 25,
                  color: Colors.green[500],
                  ),
                ]
                else if (point.type=="Ebike")...[
                  Icon(
                    Icons.directions_bike,
                    size: 25,
                    color: Colors.green[500],
                  ),
                  ]
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("${point.rating} ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: double.parse(point.rating),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 3.5),
            child: Row(
              children: [
                Text('${point.type} point - (${point.distance} km)',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (point.time!="")...[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),

            child: Row(
              children:[
                const Text('Available: ',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                ),
                Text(point.time,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

              ],
            ),
          ),
          ]
          else...[
            const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 4.0),

            child: Text(
              'Not available ',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
            ),
            )
          ],
          if (point.type=="Charger")...[
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
          ]
          else if (point.type=="Ebike") const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("Este punto posee bicicletas eléctricas")),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 5.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue[50]!),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.blueAccent)
                                  )
                              )
                          ),
                          onPressed:() {},
                          child: Row(
                            children: const [
                              Text('Route ',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                              ),
                              Icon(
                                Icons.directions,
                                size: 20,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue[50]!),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.blueAccent)
                                  )
                              )
                          ),
                          onPressed:() {},
                          child: Row(
                            children: const [
                              Text('Chat ',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                              ),
                              Icon(
                                Icons.chat,
                                size: 20,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text("Mis puntos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green[50]!),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: (){},
              child: const Icon(Icons.directions_bike),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green[50]!),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: (){},
              child: const Icon(Icons.bolt),
            ),
          ],

        ),
        Expanded(child: showMyPoints()
          )
      ],
    ));
  }

  //TODO: esto es muy turbio, habría que hacer un endpoint para esto
  String getRating(String id){
    double rate = 0;
    double count = 0;
    for (int i = 0; i < ratings.length; i++) {
      if (id == ratings[i]['id']) {
        count+=1;
        rate += double.parse(ratings[i]['rate']);

      }
    }
    if(count==0) return rate.toString();
    return (rate/count).toString();
  }

  String getDistance(String id){

    return "1";
  }

  String getTime(String id){

    return "13:00h - 14:00h";
  }

//TODO falta incluir ratings
  Widget showMyPoints()
  {
    List<Point> points = <Point>[];
/*    print("Hola es el print: "+bikes.toString());
    print("El  bisho es de tipo: "+bikes[0]['type']+" ");*/
    //TODO: refactorizar estos fors
    for (var bike in bikes) {
      Point point = Point(name: bike['title'], rating: getRating(bike['title']),
          distance: getDistance(bike['title']), time: getTime(bike['title']),
          type: "Bike");
      points.add(point);
    }

    for (var charger in chargers) {
      Point point = Point(name: charger['name'], rating: getRating(charger['title']),
          distance: getDistance(charger['name']), time: getTime(charger['name']),
          type: "Charger");
      points.add(point);
    }

    points.add(Point(name: "pruebas", rating: "4.5", distance: "2", time: "13:00 - 14:00", type: "Bike"));

    return ListView.builder(
        itemCount: points.length,
        itemBuilder: (context,i){
          return _buildCard(points[i]);
        }
    );
  }

}




