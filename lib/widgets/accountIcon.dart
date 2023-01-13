import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../services/generalServices/LoginService.dart';

class AccountIcon extends StatefulWidget {
  double percent;
  var path_image;
  ImageProvider<Object>? image_profile;

  AccountIcon({required this.percent, required this.path_image, super.key});

  @override
  State<AccountIcon> createState() => _AccountIcon();
}

class _AccountIcon extends State<AccountIcon> {
  final _loggedInStateInfo = LoginService();
  var userData;
  @override
  void initState() {
    super.initState();
    _getData();
    if(widget.path_image != null) {
      widget.image_profile = NetworkImage(widget.path_image);
    }
    else widget.image_profile = AssetImage('assets/images/default_user_img.jpg');
  }
  void _getData() async {
    var data = _loggedInStateInfo.user_info;
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(widget.path_image != null)  widget.image_profile = NetworkImage(widget.path_image);
      else widget.image_profile = AssetImage('assets/images/default_user_img.jpg');
    });
    print("_------------------------");
      return CircularPercentIndicator(
        radius: 55 ,
        lineWidth: 7.0,
        percent: widget.percent,
        center: account_icon(widget.image_profile, 48),
        progressColor: Colors.green,
        backgroundColor: Colors.white70,
    );
  }
}

Widget account_icon(ImageProvider<Object>? image,double radius){
  return  CircleAvatar(
    backgroundColor: Colors.white,
    radius: radius,
    backgroundImage: image,
  );
}

