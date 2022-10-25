import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonListScreenChargersWidget extends StatefulWidget {
  const ButtonListScreenChargersWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonListScreenChargersWidget();
}

class _ButtonListScreenChargersWidget extends State<ButtonListScreenChargersWidget>{
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      child: IconButton(
          padding: const EdgeInsets.all(10),
          iconSize: 70,
          icon: Image.asset("assets/images/punt_carregador.png"),
          onPressed: () {
            // do something
            context.go('/lib/screens/charger-info-list/chargeInfoList.dart');
          }),
    );
  }
}

//funcion del boton route situado en la car