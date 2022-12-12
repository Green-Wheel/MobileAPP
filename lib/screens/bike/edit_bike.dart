import 'package:flutter/material.dart';
import '../../serializers/bikes.dart';
import '../../services/backendServices/bikes.dart';
import '../../widgets/forms/bike_form.dart';

class EditBike extends StatefulWidget {
  final int id;
  const EditBike({Key? key, required this.id}) : super(key: key);

  @override
  State<EditBike> createState() => _EditBikeState();
}

class _EditBikeState extends State<EditBike> {
  late DetailedBikeSerializer _bikeInfo;
  bool charged = false;

  void _showAvisNoEsPotCarregarBike() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bike Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load bike info'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getBikeInfo() async {
    var bikeI = await BikeService.getBikeInfo(widget.id);
    if (bikeI == null) {
      _showAvisNoEsPotCarregarBike();
    }
    setState(() {
      _bikeInfo = bikeI;
      charged = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getBikeInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bike'),

      ),
      body: Center(
        child: !charged
            ? Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.height / 5,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : BikeForm(
                data: _bikeInfo,
              ),
      ),
    );
  }
}
