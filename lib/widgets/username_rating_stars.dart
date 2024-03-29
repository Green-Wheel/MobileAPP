import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

import '../screens/profile/editprofile.dart';
import '../screens/register/recover_password.dart';
import 'Bookings/utils/stringOverflow.dart';

class Username_Rating extends StatelessWidget {
  String username;
  String rating;
  bool edit_button;
  int id;
  Username_Rating({required this.username,required this.rating,required this.edit_button, super.key, required  this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Stack(
            children:<Widget> [
              Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(cutDownStringName(username), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

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
        GoRouter.of(context).push('/profile/$id/edit');
      },
    );
  }

  Widget chat(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chat),
      onPressed: () {
        GoRouter.of(context).push('/chats/$id');
      },
    );
  }

  Widget report(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.report),
      onPressed: () {
        GoRouter.of(context).go('/report/user/$id');
      },
    );
  }
  Widget rate(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.star_rate_sharp),
      onPressed: () {
        GoRouter.of(context).go('/profile/$id/rate/user');
      },
    );
  }


}


