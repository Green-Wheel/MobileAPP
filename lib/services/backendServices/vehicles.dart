import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/vehicles.dart';

class VehicleService {
  static Future<List<Vehicle>> getVehicles() async {
    List<Vehicle> result = [];
    await BackendService.get('vehicles/').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Vehicle.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting vehicles!');
      }
    });
    return result;
  }

  static Future<List<Vehicle>> getCars() async {
    List<Vehicle> result = [];
    await BackendService.get('vehicles/?types=car').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Vehicle.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting cars!');
      }
    });
    return result;
  }

  static Future<List<Vehicle>> getBikes() async {
    List<Vehicle> result = [];
    await BackendService.get('vehicles/?types=bike').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Vehicle.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting bikes!');
      }
    });
    return result;
  }
}