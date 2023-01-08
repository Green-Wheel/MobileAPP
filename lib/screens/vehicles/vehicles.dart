import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../serializers/users.dart';
import '../../serializers/vehicles.dart';
import '../../services/backendServices/user_service.dart';
import '../../services/backendServices/vehicles.dart';
import '../../services/generalServices/LoginService.dart';
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

User? logUser;

class _MyVehiclesPageState extends State<MyVehiclesPage> {
  List<Car> vehicles = [];
  final _loggedInStateInfo = LoginService();

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
            onPressed: () {
              GoRouter.of(context).go('/home');
              print('hey go back');
            }
          ),
        ),
        body: buildList(vehicles),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).push('/vehicles/add');
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add, color: Colors.white, size: 30.0),
            ),
          ],
        ),
    );
  }

  void getLoggedUserById(int id) async {
    logUser = await UserService.getUser(id);
  }

  void callSetState() {
    setState(() {});
  }

  Widget buildList(List<Car> vehicles) {
    final Future<String> calculation = Future<String>.delayed(
      const Duration(seconds: 1),
          () => 'Data Loaded',
    );
    var data = _loggedInStateInfo.user_info;
    return FutureBuilder(
      future: calculation,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            getLoggedUserById(data!['id']);
            return CarCard(
              car: vehicles[index],
              logUser: logUser,
              callSetState: callSetState,
            );
          },
        );
      }
    );
  }

  void goToAddVehicle() {
    GoRouter.of(context).push('/vehicles/add');
  }

  Widget currentLocationActionButton() {
    return FloatingActionButton(
      heroTag: "btn1",
      onPressed: goToAddVehicle,
      backgroundColor: Colors.white,
      child: const Icon(Icons.add, color: Colors.green, size: 30.0)
    );
  }
}

