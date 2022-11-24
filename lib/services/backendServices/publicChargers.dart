import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

class PublicChargerService {
  static Future<List?> getPublicChargers() async {
    List result = [];
    await BackendService.get('chargers/public/').then((response) {
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