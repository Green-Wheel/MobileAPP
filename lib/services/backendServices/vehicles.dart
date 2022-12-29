import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/vehicles.dart';

class VehicleService {
  static Future<List<Car>> getVehicles() async {
    List<Car> result = [];
    await BackendService.get('vehicles/').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Car.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting vehicles!');
      }
    });
    return result;
  }

  static Future<List<Car>> getVehicleModels() async {
    List<Car> result = [];
    await BackendService.get('vehicles/models').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Car.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting vehicles!');
      }
    });
    return result;
  }
}