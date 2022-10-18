import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){runApp(const MaterialApp(
  title: 'chargeInfoList try',
  home: Scaffold(
    body: ChargeInfoList(),
  ),
));}

class ChargeInfoList extends StatefulWidget {
  const ChargeInfoList({Key? key}) : super(key: key);

  @override
  State<ChargeInfoList> createState() => _ChargeInfoListState();

}

class _ChargeInfoListState extends State<ChargeInfoList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}