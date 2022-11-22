import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

import '../../serializers/bikes.dart';

class BikeService {
  static Future<List<Bike>> getBikes() async {
    List<Bike> result = [];
    await BackendService.get('chargers/').then((response) { // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => Bike.fromJson(e)).toList();
      } else {
        print('Error getting bikes!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getBikeList(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('chargers/list/?page=$pag').then((response) { // bikes/list/?page=$pag
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
      } else {
        print('Error getting charger list!');
      }
    });
    return result;
  }

  static Future<DetailedBikeSerializer?> getBike(int id) async {
    DetailedBikeSerializer? result;
    await BackendService.get('chargers/$id/').then((response) { // bike/:id/
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('heyyy $jsonResponse');
        print(result);
        result = DetailedBikeSerializer.fromJson(jsonResponse);
        print('detailed $result');
      } else {
        print('Error getting charger!');
      }
    });
    return result;
  }


  static bool deleteBikes(id) {
    BackendService.delete('bikes/$id/').then((response) {
      if (response.statusCode == 204) {
        print('Bike deleted!');
        return true;
      } else {
        print('Error deleting bike!');
        print(response.statusCode);
        return false;
      }
    });
    return false;
  }
}