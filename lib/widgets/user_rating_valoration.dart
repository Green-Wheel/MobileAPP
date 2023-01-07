import 'package:flutter/material.dart';

import 'interactive_stars_widget.dart';


class ValorateUser extends StatefulWidget {

  ValorateUser({Key? key}) : super(key: key);

  @override
  State<ValorateUser> createState() => _ValorateUser();
}

class _ValorateUser extends State<ValorateUser> {

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Enter Message'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
          ),
          InteractiveStarsWidget(rate:2),
        ]
    );
  }
}
