import "package:flutter/material.dart";

class TrophiesScreen extends StatefulWidget{
  const TrophiesScreen({Key? key}) : super(key: key);

  @override
  State<TrophiesScreen> createState() => _TrophiesScreen();
}

class _TrophiesScreen extends State<TrophiesScreen>{
  final List<int> _listData = List<int>.generate(4, (i) => i);
  final List<Image> _list_images_trophys = [
    Image.network(
      "https://www.clipartmax.com/png/middle/252-2524925_trophy-gold-medal-award-prize-achievements-clipart-png.png",
      height: 100,
      width: 100,
    ),
    Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKnemmKgJOG_3OSk89VHtpTVAUGN1Nagcvgw&usqp=CAU",
      height: 100,
      width: 100,
    ),
    Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Ee4DhiFLB8CrzquwmJjcZepednxWN6E8oQ&usqp=CAU",
      height: 100,
      width: 100,
    ),
    Image.network(
      "https://www.pinclipart.com/picdir/middle/570-5705065_xbox-controller-clip-art.png",
      height: 100,
      width: 100,
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
                child: Text("11/50",
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
                    _list_images_trophys[i],
                    SizedBox(
                      width: 5,
                    ), // the space between image and text
                    Text("Achievementx $i"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}