import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/bikes.dart';

import '../../../serializers/users.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../widgets/image_display.dart';

class UserBasicInfo extends StatefulWidget {
  final user_id;

  const UserBasicInfo({Key? key, required this.user_id})
      : super(key: key);

  @override
  State<UserBasicInfo> createState() => _UserBasicInfoState();
}

class _UserBasicInfoState extends State<UserBasicInfo> {
  late User _user;

  void _getBike() async {
    User? aux =
    await UserService.getUserInfo(widget.user_id);
    setState(() {
      _user = aux;
    });
  }

  @override
  initState() {
    super.initState();
    _getBike();
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
                        _user.username ?? "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(_user.first_name ?? ""),
                      Text(_user.about ?? ""),
                    ],
                  )),
            ]),
          )),
    );
  }
}
