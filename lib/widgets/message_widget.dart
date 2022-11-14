import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  double rate;
  MessageWidget({required this.rate, super.key});

  @override
  State<StatefulWidget> createState() => _MessageWidget();
}

class _MessageWidget extends State<MessageWidget>{
  @override
  Widget build(BuildContext context) {
    return _messageWidget(widget.rate);
  }
}

main() {
  runApp(MaterialApp(
    home: MessageWidget(rate: 0.0),
  ));
}

//funcion para mostrar las estrellas
Widget _messageWidget(double rate){
  return rate == 0.0 ? Text('No hay comentarios') : Text('Hay comentarios');
}