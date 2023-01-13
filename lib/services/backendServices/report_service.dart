import 'dart:convert';

import 'package:greenwheel/serializers/reports.dart';
import 'package:greenwheel/services/backend_service.dart';

class ReportService {
  static Future<bool> reportPublication(
      int publication_id, String description, int reason) async {
    var response = await BackendService.post(
        'reports/publication/$publication_id/',
        {'message': description, 'reason': reason});
    if (response.statusCode == 201) {
      print('publication reported!');
      return true;
    } else {
      print('Error reporting publication!');
      return false;
    }
  }

  static Future<bool> reportRating(
      int rating_id, String description, int reason) async {
    var response = await BackendService.post('reports/rating/$rating_id/',
        {'message': description, 'reason': reason});
    if (response.statusCode == 201) {
      print('Rating reported!');
      return true;
    } else {
      print('Error reporting rating!');
      return false;
    }
  }

  static Future<bool> reportUser(
      int user_id, String description, int reason) async {
    print('user_id: $user_id \n description: $description \n reason: $reason');
    var response = await BackendService.post(
        'reports/user/$user_id/', {'message': description, 'reason': reason});
    if (response.statusCode == 201) {
      print('User reported!');
      return true;
    } else {
      print('Error reporting user!');
      print(response.statusCode);
      return false;
    }
  }

  static Future<List<ReportReasonSerializer>> getReportTypes() async {
    List<ReportReasonSerializer> result = [];
    var response = await BackendService.get('reports/reasons/');
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);
      result = jsonResponse.map((e) => ReportReasonSerializer.fromJson(e)).toList();
    } else {
      print('Error getting report types!');
    }
    return result;
  }
}
