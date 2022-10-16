import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){runApp(const MaterialApp(
  title: 'chargeInfoList try',
  home: Scaffold(
    body: ChargeInfoList(),
  ),
));}

class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}
List<String> elements = [
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
  "Hey", "hola", "sep", "yep", "prova",
];

class _ChargeInfoListState extends State<ChargeInfoList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 25,
        itemBuilder: (context, position) {
          return Dismissible(
            key: Key(elements[position]),
            child: Card(
              elevation: 10,
              shape:  const RoundedRectangleBorder(
                side: BorderSide(
                color: Color(0xff43802a),
                width: 4,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(
                height: 162.5,
                child:Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45.0, bottom: 3.0, top: 25.0) ,
                          child: Row(
                            children: [
                              const Text("location",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0, bottom: 3.0),
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
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("rating".toString(),
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 48.0, bottom: 3.5),
                          child: Row(
                            children: [
                              Text('Point of charge - ( km)',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, bottom: 4.0),
                          child: Row(
                            children:[
                              const Text('Available: ',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                              Text("time",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45.0),
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
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 18, 5, 0),
                            child: SizedBox(
                              height: 90.0,
                              child: Image.asset("assets/images/punt_carregador.png"),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.blueAccent, // foreground
                              ),
                              onPressed:() {},
                              child: Row(
                                children: [
                                  Text('Route ',
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                                  ),
                                  Icon(
                                    Icons.turn_slight_right_rounded,
                                    size: 20,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
/*class listaCards extends StatelessWidget {
  const listaCards(List<String> elements, int position, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          height: 100.0,
          child: Row(
            children: [
              Text(listaCards[position]),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}*/