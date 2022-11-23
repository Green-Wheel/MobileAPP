import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AccountIcon extends StatelessWidget {
  double percent;
  String path_image;
  AccountIcon({required this.percent, required this.path_image,super.key});

  @override
  Widget build(BuildContext context) {
      return CircularPercentIndicator(
        radius: 55 ,
        lineWidth: 7.0,
        percent: percent,
        center: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 48,
          backgroundImage: AssetImage(path_image),
        ),
        progressColor: Colors.green,
        backgroundColor: Colors.white70,
    );
  }
}


