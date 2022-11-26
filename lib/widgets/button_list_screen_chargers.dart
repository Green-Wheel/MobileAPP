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
    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go('/chargers/list');
      },
      child: const Icon(
        Icons.list,
        size: 35,
      ),
      backgroundColor: Colors.green,
    );
  }
}

