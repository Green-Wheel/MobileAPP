import 'dart:convert';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/chargers.dart';

class PrivateChargersService{
  static Future<List> getSpeeds() async {
    List<SpeedType> result = [];
    var response = await BackendService.get('chargers/speed/');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
        result = json.map((item) => SpeedType.fromJson(item)).toList();
    } else {
      throw Exception('Error getting speeds');
    }
    return result;
  }
}