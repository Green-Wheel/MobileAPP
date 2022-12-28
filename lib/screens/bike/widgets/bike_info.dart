import 'package:flutter/material.dart';
import 'package:greenwheel/serializers/bikes.dart';
import 'package:greenwheel/services/backendServices/bikes.dart';

import '../../../serializers/chargers.dart';
import '../../../services/backendServices/chargers.dart';
import '../../../widgets/image_display.dart';

class BikeBasicInfo extends StatefulWidget {
  final bike_id;

  const BikeBasicInfo({Key? key, required this.bike_id})
      : super(key: key);

  @override
  State<BikeBasicInfo> createState() => _BikeBasicInfoState();
}

class _BikeBasicInfoState extends State<BikeBasicInfo> {
  var _bike;

  void _getBike() async {
    DetailedBikeSerializer? aux =
        await BikeService.getBike(widget.bike_id);
    setState(() {
      _bike = aux;
    });
  }

  @override
  initState() {
    super.initState();
    _getBike();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    _bike?.title ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(_bike?.description ?? ""),
                  Text(_bike?.direction ?? ""),
                ],
              )),
              ImageDisplay(
                images: _bike?.images ?? [].map((e) => e.url).toList(),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
              ),
            ]),
          )),
    );
  }
}
