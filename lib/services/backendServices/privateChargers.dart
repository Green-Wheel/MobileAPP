import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

class PrivateChargerService {
  static Future<List?> getPrivateChargers() async {
    List result = [];
    await BackendService.get('chargers/private/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse;
      } else {
        print('Error getting private chargers!');
      }
    });
    return result;
  }
}