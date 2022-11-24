import 'package:flutter/material.dart';

class TopText extends StatefulWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome\nBack',
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
