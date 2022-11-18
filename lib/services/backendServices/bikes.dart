import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

class Bikes {
  static Future<List?> getBikes() async {
    List result = [];
    await BackendService.get('chargers/public/').then((response) { // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse;
      } else {
        print('Error getting bikes!');
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