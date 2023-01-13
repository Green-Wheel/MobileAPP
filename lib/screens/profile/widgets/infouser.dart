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

  @override
  _InfoUser createState() => _InfoUser ();
}

class _InfoUser extends State<InfoUser>  {
  bool edit_button = false;
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
        edit_button = true;
        userData = data;
      });
    }
    else {
      Map<String,dynamic> data = await UserService.getUserMap(widget.id) as Map<String, dynamic>;
      setState(() {
        userData = data;
        edit_button = false;
      });
    }
  }
  Widget edit(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        GoRouter.of(context).push('/profile/${widget.id}/edit');
      },
    );
  }

  Widget chat(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chat),
      onPressed: () {
        GoRouter.of(context).push('/chats/${widget.id}');
      },
    );
  }

  Widget report(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.report),
      onPressed: () {
        GoRouter.of(context).go('/report/user/${widget.id}');
      },
    );
  }
  Widget rate(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.star_rate_sharp),
      onPressed: () {
        GoRouter.of(context).go('/profile/${widget.id}/rate/user');
      },
    );
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
                              edit_button: edit_button, id: widget.id
                          ),
                          Row(
                            children: [
                              (edit_button) ? edit(context) : chat(context),
                              (edit_button) ? Container() : report(context),
                              (edit_button) ? Container() : rate(context),
                            ],
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

