import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/bikes.dart';

import '../../../serializers/users.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../services/generalServices/LoginService.dart';
import '../../../widgets/image_display.dart';

class UserBasicInfo extends StatefulWidget {
  final user_id;

  const UserBasicInfo({Key? key, required this.user_id}) : super(key: key);

  @override
  State<UserBasicInfo> createState() => _UserBasicInfoState();
}

class _UserBasicInfoState extends State<UserBasicInfo> {
  User _user = User(username: '', email: '', about: '', first_name: '', last_name: '', language_id: 0, level: 0, xp: 0, rating: 0, selected_car: 0);
  final _loginService = LoginService();

  void _getUser() async {
    User? aux = await UserService.getUserInfo(widget.user_id);
    setState(() {
      _user = aux;
    });
  }

  @override
  initState() {
    super.initState();
    _getUser();
    print('ApiKey:   ------- \n${_loginService.apiKey}');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'username: ${_user.username}' ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('about: ${_user.about}' ?? "", style: const TextStyle(fontSize: 20),),
                  Text('rating: ${_user.rating}' ?? "", style: const TextStyle(fontSize: 20),),
                ],
              )),
              _user.profile_picture != null
                  ? Image.network(
                      _user.profile_picture ?? '',
                      width: MediaQuery.of(context).size.width * 0.2,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/no_image.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      fit: BoxFit.cover,
                    ),
            ]),
          )),
    );
  }
}
