import 'package:flutter/material.dart';
import '../../services/backendServices/bikes.dart';
import '../../widgets/forms/bike_form.dart';

class EditBike extends StatefulWidget {
  final int id;
  const EditBike({Key? key, required this.id}) : super(key: key);

  @override
  State<EditBike> createState() => _EditBikeState();
}

class _EditBikeState extends State<EditBike> {
  Map<String, dynamic> _bikeInfo = {};

  void getBikeInfo() async {
    var bikeI = await BikesService.getBikeInfo(widget.id);
    setState(() {
      _bikeInfo = bikeI;
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
        child: _bikeInfo.isEmpty
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