import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  _InfoUser createState() => _InfoUser ();
}

class _InfoUser extends State<InfoUser>  {
  bool _isEditable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top:0,left:20,right:20),
        child: Column(
            children : <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(Icons.account_circle,size:120,color:Colors.green),
                      Column(
                        children: <Widget>[
                          name_edit(),
                          ratingIndicator(),
                          const Text("lvl 10 | 10.846 points"),
                          const Text("Trophies")
                        ],
                      ),
                    ],
                  )
              ),
            ]
        )
    );
  }
  Widget name_edit() {
    return Row(
        children: <Widget>[
          SizedBox(width: 50),
          const Text("Isslam Benali",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ]
    );
  }
    Widget ratingIndicator(){
      return Row(
          children: <Widget>[
              Text("3",style: TextStyle(fontSize: 18)),
              RatingBarIndicator(
                rating: 3,
                itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 22.0,
                direction: Axis.horizontal,
              ),
         ]
      );
    }
}

