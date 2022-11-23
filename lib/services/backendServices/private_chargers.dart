import 'dart:convert';
import 'package:greenwheel/services/backend_service.dart';
import '../../../serializers/chargers.dart';
import 'dart:io';

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

  static Future<bool> newCharger(Map<String, dynamic> data, List<File> images) async {
    try {
      var response = await BackendService.post('chargers/', data);
      if (response.statusCode != 200) return false;
      var json = jsonDecode(response.body);
      var response2  = await BackendService.postFiles('publications/${json['id']}/upload/', images);
      return response2.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}


























