import 'package:flutter/material.dart';
import '../../../serializers/users.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../widgets/accountIcon.dart';
import '../../../widgets/username_rating_stars.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  _InfoUser createState() => _InfoUser ();
}

class _InfoUser extends State<InfoUser>  {
  bool _isEditable = true;
  User? user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }
  void _getUser() async {
    User? aux = await UserService.getUser();
    setState(() {
      user = aux;
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
                      AccountIcon(percent: 0.5, path_image: user?.profile_picture ?? 'assets/images/default_user_img.jpg'),
                      Column(
                        children: <Widget>[
                          if(_isEditable) Username_Rating(username: user?.username ?? "",
                              rating : user?.rating?.toString() ?? "1",
                            edit_button: true,)
                          else Username_Rating(username: user?.username ?? "",
                            rating : user?.rating?.toString() ?? "1",
                            edit_button: false,),
                          Text("lvl ${user?.level} |  ${user?.xp} xp" ?? "1 + | 0 xp"),
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

