import 'package:flutter/material.dart';
import '../../../services/generalServices/LoginService.dart';
import '../../../widgets/accountIcon.dart';
import '../../../widgets/username_rating_stars.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  _InfoUser createState() => _InfoUser ();
}

class _InfoUser extends State<InfoUser>  {

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

    return Container(
        padding: const EdgeInsets.only(top:0,left:0,right:0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/4,
        child: Column(
            children : <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AccountIcon(percent: 0.5, path_image: 'assets/images/default_user_img.jpg'),
                      Column(
                        children: <Widget>[
                          Center(
                          child: Username_Rating(username: userData != null
                              ? userData['first_name'] + " " + userData['last_name']
                                  : "User Name",
                              rating :userData['rating']!=null ? userData['rating'].toString() : "2.5",
                              edit_button: true),
                          ),
                          Text("lvl ${userData['level']} |  lvl ${userData['xp']} xp" ?? "1 + | 0 xp"),
                          Text("Trophies")
                        ],
                      ),
                    ],
                  )
              ),
            ]
        )
    );
  }
}

