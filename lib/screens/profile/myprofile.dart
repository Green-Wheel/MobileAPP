import 'package:flutter/material.dart';
import 'package:greenwheel/screens/profile/widgets/aboutMe.dart';
import 'package:greenwheel/screens/profile/widgets/infouser.dart';
import 'package:greenwheel/screens/profile/widgets/mypoints.dart';
import '../../services/generalServices/LoginService.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required id}) : id=id,super(key: key);
  int id;
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
            child: InfoUser(widget.id),
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
            child:  (userData['id'] == widget.id) ? AboutMe(userData['id']) : AboutMe(widget.id),//ficar user
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
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child:
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("My Posts",
                      style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                ]
              )
          ),
          Container(
           // height: MediaQuery.of(context).size.height/2,
            child: (userData['id'] == widget.id) ? MyPoints(userData['id']) : MyPoints(widget.id),
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
