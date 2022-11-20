import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

class Username_Rating extends StatelessWidget {
  String username;
  String rating;

  Username_Rating({required this.username,required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(username,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          RatingStars(rating: rating),
        ]
    );
  }
}

