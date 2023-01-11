import 'package:flutter/material.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../services/generalServices/LoginService.dart';
import '../../../widgets/accountIcon.dart';
import '../../../widgets/username_rating_stars.dart';

class AboutMe extends StatefulWidget {
  AboutMe(id,  {Key? key}) : id = id ,super(key: key);
  int id;
  @override
  _AboutMe createState() => _AboutMe ();
}

class _AboutMe extends State<AboutMe>  {
  final _loggedInStateInfo = LoginService();
  var userData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    var data = _loggedInStateInfo.user_info;

    if(widget.id  == data?['id']){
      setState(() {
        userData = data;
      });
    }
    else {
      Map<String,dynamic> data = await UserService.getUserMap(widget.id) as Map<String, dynamic>;
      setState(() {
        userData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

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
                    (userData?['about']!=null) ? userData['about'] : "You haven't typed down an about",
                    style: TextStyle(fontSize: 16)
                ),
              ),

            ]
        )
    );
  }
}
