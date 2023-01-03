import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

class ReportService {


  /*static Future<bool> reportBike(int bike_id, String report_type) async {
    var response = await BackendService.post('bikes/$bike_id/report/',
        body: {'report_type': report_type});
    if (response.statusCode == 201) {
      print('Bike reported!');
      return true;
    } else {
      print('Error reporting bike!');
      return false;
    }
  }*/

  static Future<List<String>> getReportTypes() async {
    List<String> result = [];
    var response = await BackendService.get('reports/');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);
      result = jsonResponse.map((e) => e as String).toList();
      print(result);
    } else {
      print('Error getting report types!');
    }
    return result;
  }

}