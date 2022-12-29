import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../serializers/vehicles.dart';
import '../../services/backendServices/vehicles.dart';
import '../../widgets/CarCard.dart';

void main() {
  runApp(const MyVehicles());
}

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vehicles',
      theme: ThemeData(
        backgroundColor: Colors.white, //CupertinoColors.extraLightBackgroundGray,
      ),
      home: const MyVehiclesPage(),
    );
  }
}

class MyVehiclesPage extends StatefulWidget {
  const MyVehiclesPage({Key? key}) : super(key: key);

  @override
  _MyVehiclesPageState createState() => _MyVehiclesPageState();
}

class _MyVehiclesPageState extends State<MyVehiclesPage> {
  List<Car> vehicles = [];

  @override
  void initState() {
    super.initState();
    _getVehicles();
  }

  void _showAvisNoEsPodenCarregarVehicles() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vehicles Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load vehicles'),
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

  void _getVehicles() async {
    List<Car> vehicleList = await VehicleService.getVehicles();
    if (vehicleList.isEmpty) {
      _showAvisNoEsPodenCarregarVehicles();
    }
    print("vehicles: $vehicleList");
    setState(() {
      vehicles = vehicleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Vehicles'),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width / 3.5),
              child: const Icon(Icons.directions_car),
            ),
          ],
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: buildList(vehicles)
    );
  }
}

Widget buildList(List<Car> vehicles) => ListView.builder(
  itemCount: vehicles.length,
  itemBuilder: (context, index) {
    return CarCard(
      car: vehicles[index],
    );
  },
);

