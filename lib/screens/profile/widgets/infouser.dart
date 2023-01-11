import 'package:flutter/material.dart';
import '../../../serializers/users.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../services/generalServices/LoginService.dart';
import '../../../widgets/accountIcon.dart';
import '../../../widgets/username_rating_stars.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:go_router/go_router.dart';

class InfoUser extends StatefulWidget {
  InfoUser(id,  {Key? key}) : id = id ,super(key: key);
  int id;
  bool edit_button = false;
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

    if(widget.id  == data?['id']){
      setState(() {
        widget.edit_button = true;
        userData = data;
      });
    }
    else {
      Map<String,dynamic> data = await UserService.getUserMap(widget.id) as Map<String, dynamic>;
      setState(() {
        userData = data;
        widget.edit_button = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int aux = widget.id;
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
                      AccountIcon(percent: 0.5, path_image: userData?["profile_picture"]),
                      Column(
                        children: <Widget>[
                          Username_Rating(username: userData != null
                              ? userData['first_name'] + " " + userData['last_name']
                                  : "User Name",
                              rating :userData?['rating'] !=null ? userData['rating'].toString() : "2.5",
                              edit_button: widget.edit_button, id: widget.id
                          ),
                          Text('Username: ${userData?['username']}'),
                          Text("lvl ${userData?['level']} |  lvl ${userData?['xp']} xp" ?? "1 + | 0 xp"),
                          Row(
                            children:[
                              Text("Trophies"),
                              IconButton(
                                iconSize: 20,
                                icon: const Icon(MdiIcons.trophy),
                                onPressed: () {
                                  GoRouter.of(context).go('/profile/$aux/trophies');
                                },
                              ),
                            ]
                          )
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

