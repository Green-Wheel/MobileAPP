import 'package:flutter/material.dart';

import '../serializers/ratings.dart';
import '../serializers/users.dart';
import 'interactive_stars_widget.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_box/comment/test.dart';
import 'package:comment_box/main.dart';


class ValorateUser extends StatefulWidget {

  ValorateUser({Key? key}) : super(key: key);

  @override
  State<ValorateUser> createState() => _ValorateUser();
}

class _ValorateUser extends State<ValorateUser> {

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  Rating dummy = Rating(user: BasicUser(
      id: 2, username: "Miau", first_name: "Guau", last_name: "Crack"),
      rate: 3, comment: "FIUM", created_at: DateTime.now());
  List _ratings = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    setState(() {
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 0, left: 20),
        child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Rate the User",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Message'),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
              ),
              Row(
                  children: <Widget>[
                    Text("Tap the stars to rate   "),
                    InteractiveStarsWidget(rate: 2.5),
                  ]
              ),

            ]
        )
    );
  }
}


