import 'package:flutter/material.dart';

void main() => runApp(const BikeCard());

class BikeCard extends StatelessWidget {
  const BikeCard({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    bool nothing = true;

    return Visibility(
      visible: isVisible,
      child: Center(
        child: Card(
          elevation: 7,
          color: Colors.white,
          shadowColor: Colors.black,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Icon(Icons.pedal_bike, color: Colors.green),
                  ),
                  title: const Text('Bike'),
                  subtitle: const Text('Tipus - Electric\nVelocitats - 7'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<
                            Color>(Colors.red[50]!),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    18.0),
                                side: const BorderSide(
                                    color: Colors.red)
                            )
                        )
                    ),
                    onPressed: () {
                      isVisible = false;
                    },
                    child: Row(
                      children: const [
                        Text('Eliminar',
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
