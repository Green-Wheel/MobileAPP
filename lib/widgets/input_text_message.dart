import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/button_send_message.dart';

class InputTextMessageWidget extends StatefulWidget {
  const InputTextMessageWidget({super.key});

  @override
  State<StatefulWidget> createState() => _InputTextMessageWidget();
}

main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 400),
            SizedBox(
            width: 400,
              child: Card(
                margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message',
                    prefix: const SizedBox(
                      width: 10,
                    ),
                    //TODO: poner icono de enviar widget creado
                    suffixIcon: ButtonSendMessageWidget(),
                  ),
                ),
              ),
            )
        ],
      ),
    ),
  ));
}

class _InputTextMessageWidget extends State<InputTextMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type a message',
            prefix: const SizedBox(
              width: 10,
            ),
            //TODO: poner icono de enviar widget creado
            suffixIcon: ButtonSendMessageWidget(),
            ),
          ),
        ),
      );
  }
}
