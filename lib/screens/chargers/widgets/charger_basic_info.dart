import 'package:flutter/material.dart';

import '../../../serializers/chargers.dart';
import '../../../services/backendServices/chargers.dart';
import '../../../widgets/image_display.dart';

class ChargerBasicInfo extends StatefulWidget {
  final charger_id;

  const ChargerBasicInfo({Key? key, required this.charger_id})
      : super(key: key);

  @override
  State<ChargerBasicInfo> createState() => _ChargerBasicInfoState();
}

class _ChargerBasicInfoState extends State<ChargerBasicInfo> {
  var _charger;

  void _getCharger() async {
    DetailedCharherSerializer? aux =
        await ChargerService.getCharger(widget.charger_id);
    setState(() {
      _charger = aux;
    });
  }

  @override
  initState() {
    super.initState();
    _getCharger();
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
                    _charger?.title ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(_charger?.description ?? ""),
                  Text(_charger?.direction ?? ""),
                ],
              )),
              ImageDisplay(
                images: _charger?.images ?? [].map((e) => e.url).toList(),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
              ),
            ]),
          )),
    );
  }
}
