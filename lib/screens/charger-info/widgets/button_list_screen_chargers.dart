import 'package:flutter/material.dart';

class ButtonListScreenChargersWidget extends StatefulWidget {
  const ButtonListScreenChargersWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonListScreenChargersWidget();
}

class _ButtonListScreenChargersWidget extends State<ButtonListScreenChargersWidget>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // do something
        //context.go('../../charger-info-list/chargeInfoList.dart');
      },
      child: Icon(
        Icons.list,
        size: 35,
      ),
      backgroundColor: Colors.green,
    );
    ElevatedButton(
      onPressed: () {
        // do something
        //context.go('../../charger-info-list/chargeInfoList.dart');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
      ),
      child: Icon(
        Icons.list,
        size: 35,
      ),
    );
  }
}

//funcion del boton route situado en la car