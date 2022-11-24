import 'dart:convert';
import '../backend_service.dart';

class BikesService {
  static Future<bool> newBike(Map<String, dynamic> data, images) async {
    try {
      var response = await BackendService.post('bikes/', data);
      if (response.statusCode != 200) return false;
      var json = jsonDecode(response.body);
      var response2 = await BackendService.postFiles(
          'publications/${json['id']}/upload/', images);
      return response2.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map<String, dynamic>> getBikeInfo(int id) async {
    Map<String, dynamic> result = {};
    var response = await BackendService.get('bikes/$id/');
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    } else {
      throw Exception('Error getting bike info');
    }
    return result;
  }

  static Future<bool> updateBike(Map<String, dynamic> data) async {
    try {
      var response = await BackendService.put('bikes/${data['id']}/', data);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
