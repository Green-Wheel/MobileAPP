import 'dart:convert';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/chargers.dart';

class PrivateChargersService{
  static Future<List<dynamic>> getSpeeds() async {
    List<dynamic> result = [];
    var response = await BackendService.get('chargers/speed/');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
        result = json.map((item) => SpeedType.fromJson(item)).toList();
    } else {
      throw Exception('Error getting speeds');
    }
    return result;
  }

  static Future<List<dynamic>> getConnectionTypes() async {
    List<dynamic> result = [];
    var response = await BackendService.get('chargers/connection/');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      result = json.map((item) => ConnectionType.fromJson(item)).toList();
    } else {
      throw Exception('Error getting Connection Types');
    }
    return result;
  }

  static Future<List<dynamic>> getCurrentTypes() async {
    List<dynamic> result = [];
    var response = await BackendService.get('chargers/current/');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      result = json.map((item) => ConnectionType.fromJson(item)).toList();
    } else {
      throw Exception('Error getting Current Types');
    }
    return result;
  }
}