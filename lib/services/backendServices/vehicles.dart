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
        print(response.body);
        print('Error getting vehicles!');
      }
    });
    return result;
  }

  static Future<CarsDetailed?> getVehicleSerialized(int id) async {
    CarsDetailed? result;
    var response = await BackendService.get('vehicles/$id/');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      result = CarsDetailed.fromJson(jsonResponse);
    } else {
      throw Exception('Error getting vehicle with id $id');
    }
    return result;
  }

  static Future<Map<String, dynamic>> getVehicle(int id) async {
    try {
      var response = await BackendService.get('vehicles/$id/');
      if (response.statusCode != 200) return {};
      print(response.body);
      var json = jsonDecode(response.body);
      print(json);
      var data = {
        'id': json['id'],
        'alias': json['alias'] ?? '',
        'charge_capacity': json['charge_capacity'] ?? 0.0,
        'car_license': json['car_license'] ?? '',
        'model': {
          'id': json['model']['id'] ?? 0,
          'name': json['model']['name'] ?? '',
          'year': json['model']['year'],
          'autonomy': json['model']['autonomy'] ?? 0.0,
          'car_brand': {
            'id': json['model']['car_brand']['id'],
            'name': json['model']['car_brand']['name'] ?? '',
          },
          'current_type': json['model']['current_type'].map((item) => item['id']).toList() ?? [],
          'connection_type': json['model']['connection_type'].map((item) => item['id']).toList() ?? [],
          'consumption': json['model']['consumption'] ?? 0.0,
        },
      };
      return data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  static Future<List<CarBrand>> getVehicleBrands() async {
    List<CarBrand> result = [];
    await BackendService.get('vehicles/brands/').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => CarBrand.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting vehicle brands!');
      }
    });
    return result;
  }

  static Future<List<CarModel>> getVehicleBrand(int brand_id) async {
    List<CarModel> result = [];
    await BackendService.get('vehicles/brands/$brand_id/models').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => CarModel.fromJson(e)).toList();
        //print(result);
      } else {
        print('Error getting vehicle brands!');
      }
    });
    return result;
  }

  static Future<List<CarBrandYear>> getVehicleBrandYear(int brand_id, int model_id) async {
    List<CarBrandYear> result = [];
    await BackendService.get('vehicles/brands/$brand_id/models/$model_id/years').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => CarBrandYear.fromJson(e)).toList();
        //print(result);
      } else {
        print('Error getting vehicle brands!');
      }
    });
    return result;
  }

  static bool deleteVehicle(id) {
    BackendService.delete('vehicles/$id/').then((response) {
      if (response.statusCode == 204) {
        print('Vehicle deleted!');
        return true;
      } else {
        print('Error deleting vehicle!');
        print(response.statusCode);
        return false;
      }
    });
    return false;
  }

  static Future<bool> selectVehicle(int? selected_car, bool toNull) async {
    try {
      Map<String,dynamic> body = {
        'selected_car': selected_car,
      };

      if (toNull) {
        body = {
          'selected_car': null
        };
      }
      var response = await BackendService.put('vehicles/$selected_car/select/', body);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> putVehicle(Map<String, dynamic> data) async {
    try {
      var response = await BackendService.put('vehicles/${data['id']}/', data);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> postVehicle(Map<String, dynamic> data) async {
    try {
      var response = await BackendService.post('vehicles/', data);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}