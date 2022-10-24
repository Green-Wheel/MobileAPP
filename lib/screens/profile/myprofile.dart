import 'package:flutter/material.dart';
import 'package:greenwheel/screens/profile/widgets/aboutme.dart';
import 'package:greenwheel/screens/profile/widgets/infouser.dart';
import 'package:greenwheel/screens/profile/widgets/mypoints.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top:20),
            child: InfoUser(),
          ),
          Container(
            padding : const EdgeInsets.only(top:30),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:20),
            child: AboutMe(),
          ),
          Container(
            padding : const EdgeInsets.only(top:30),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:20),
            child: MyPoints(),
          ),
        ],
      ),
    );
  }
}
