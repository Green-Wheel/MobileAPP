import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

import '../screens/profile/editprofile.dart';

class Username_Rating extends StatelessWidget {
  String username;
  String rating;
  bool edit_button;
  Username_Rating({required this.username,required this.rating,required this.edit_button, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Stack(
            children:<Widget> [
              Container(
                      child: Row(
                          children: <Widget>[
                            Text(username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            if(edit_button) edit(context),
                      ],
                    ),
            ),
            ]
          ),
          RatingStars(rating: rating),
        ]
    );
  }

  Widget edit(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  (EditProfile())),
        );
      },
    );
  }
}


