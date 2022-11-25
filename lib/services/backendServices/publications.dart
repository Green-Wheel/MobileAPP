import 'dart:convert';
import 'dart:developer';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';


class PublicationService {
  static Future<List?> getBlockedHoursByDay(data) async {
    try{
      List result = [];
      await BackendService.get('${data['id']}/ocupation/${data['year']}/${data['month']}/${data['day']}/').then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as List<dynamic>;
          result = jsonResponse;
        } else {
          log('Error getting blocked hours for ${data['year']}/${data['month']}/${data['day']}');
        }
      });
    }
    catch(e){
      log(e.toString());
    }


  }

}
