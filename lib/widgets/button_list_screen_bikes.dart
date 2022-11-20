import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonListScreenBikesWidget extends StatefulWidget {
  const ButtonListScreenBikesWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonListScreenBikesWidget();
}

class _ButtonListScreenBikesWidget extends State<ButtonListScreenBikesWidget>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go('/bikes/list');
      },
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.list,
        size: 35,
      ),
    );
  }
}
