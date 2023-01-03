import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

class ReportService {
  static Future<bool> reportPublication(
      int publication_id, String description, String reason) async {
    var response = await BackendService.post(
        'reports/publication/$publication_id/',
        {description: description, reason: reason});
    if (response.statusCode == 200) {
      print('publication reported!');
      return true;
    } else {
      print('Error reporting publication!');
      return false;
    }
  }

  static Future<bool> reportRating(
      int rating_id, String description, String reason) async {
    var response = await BackendService.post('reports/rating/$rating_id/',
        {description: description, reason: reason});
    if (response.statusCode == 200) {
      print('Rating reported!');
      return true;
    } else {
      print('Error reporting rating!');
      return false;
    }
  }

  static Future<bool> reportUser(
      int user_id, String description, String reason) async {
    var response = await BackendService.post(
        'reports/user/$user_id/', {description: description, reason: reason});
    if (response.statusCode == 200) {
      print('User reported!');
      return true;
    } else {
      print('Error reporting user!');
      return false;
    }
  }

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
