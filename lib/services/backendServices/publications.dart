import 'dart:convert';
import 'dart:developer';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';


class PublicationService {
  static Future<List?> getBlockedHoursByDay(data) async {
    log("DENTRO DE LA LLAMADA A BACKEND");
    log('publications/${data['id']}/occupation/${data['year']}/${data['month']}/${data['day']}/');
    List result = [];
     try{
      await BackendService.get('publications/${data['id']}/occupation/${data['year']}/${data['month']}/${data['day']}/').then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as List<dynamic>;
          result = jsonResponse;
          log("\n\n###############################Resultado de la query ${result.toString()}\n\n");
        } else {
          log(response.statusCode.toString());
          log('Error getting blocked hours for ${data['year']}/${data['month']}/${data['day']}');
        }
      });
    }
    catch(e){
      log(e.toString());
    }

    return result;
  }

  static Future<bool> editOcuppation(data) async {
    log("DENTRO DE LA LLAMADA A BACKEND editOcuppation");
    log('publications/${data['id']}/occupation/${data['occupationId']}/');
    try{
      Map<String, dynamic> jsonMap = {"startdate":data['startDate'],"enddate":data['endDate']};
      await BackendService.put('publications/${data['id']}/occupation/${data['occupationId']}/',jsonMap).then((response) {
        if (response.statusCode == 200) {
          log("Edited ocuppation period");
          return true;
        } else {
          log('Error editing occupation period on call publications/${data['id']}/occupation/${data['occupationId']}/');
        }
      });
    }
    catch(e){
      log(e.toString());
    }
    return false;
  }

}