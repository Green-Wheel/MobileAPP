import 'package:flutter/material.dart';
import 'package:greenwheel/screens/profile/widgets/infouser.dart';
import 'package:greenwheel/screens/profile/widgets/mypoints.dart';
import '../../serializers/users.dart';
import '../../services/generalServices/LoginService.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();

}

class _ProfilePage extends State<ProfilePage> {
  final _loggedInStateInfo = LoginService();
  var userData;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    var data = _loggedInStateInfo.user_info;
    print(data);
    setState(() {
      userData = data;
    });
  }
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/5,
            padding: const EdgeInsets.only(top:20),
            child: InfoUser(),
          ),
          Container(
            padding : const EdgeInsets.only(top:0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:5),
            child: aboutMe( userData['about'] != null ? userData['about'] : "No content aboutMe"),//ficar user
          ),
          Container(
            padding : const EdgeInsets.only(top:5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:10),
            child: MyPoints(userData['id']),
          ),
        ],
      ),
    );
  }

  Widget aboutMe(String aboutMe) {
    return Container(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("About Me",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    aboutMe,
                    style: TextStyle(fontSize: 16)
                ),
              ),

            ]
        )
    );
  }
}
