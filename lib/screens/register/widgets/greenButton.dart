import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  GreenButton(String text, {Key? key, required this.onPressed}) : buttonText = text, super(key: key);
  String buttonText;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                        )
                    )
                ),
                onPressed: () {
                  onPressed();
                },
                child: Text(buttonText, style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,),),
              ),
            ),
          ),
        ]
    );
  }
}


