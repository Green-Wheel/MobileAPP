import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import 'package:greenwheel/serializers/chargers.dart';

class ChargerService {
  static Future<List<Charger>> getChargers() async {
    List<Charger> result = [];
    await BackendService.get('chargers/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => Charger.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting chargers!');
      }
    });
    return result;
  }

  static List<Charger>? getPublicChargers() {
    List<Charger>? result = [];
    BackendService.get('chargers/?type=public/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => Charger.fromJson(e)).toList();
      } else {
        print('Error getting public chargers!');
      }
    });
    return result;
  }

  static List<Charger>? getPrivateChargers() {
    List<Charger>? result = [];
    BackendService.get('chargers/?type=private/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => Charger.fromJson(e)).toList();
      } else {
        print('Error getting private chargers!');
      }
    });
    return result;
  }

  static List<Charger>? getChargerList(int pag) {
    List<Charger>? result = [];
    BackendService.get('chargers/list/?page=$pag/').then((response) { // per pàgines
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => Charger.fromJson(e)).toList();
      } else {
        print('Error getting charger list!');
      }
    });
    return result;
  }

  static Charger? getCharger(int id) {
    Charger? result;
    BackendService.get('chargers/$id/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = Charger.fromJson(jsonResponse);
      } else {
        print('Error getting charger!');
      }
    });
    return result;
  }

  static Charger? postCharger(int id, Map<String, dynamic> jsonMap) {
    Charger? result;
    BackendService.post('chargers/$id/', jsonMap).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = Charger.fromJson(jsonResponse);
      } else {
        print('Error posting charger!');
      }
    });
    return result;
  }

  static Charger? deleteCharger(int id) {
    Charger? result;
    BackendService.delete('chargers/$id/').then((response) {
      if (response.statusCode == 204) {
        var jsonResponse = jsonDecode(response.body);
        result = Charger.fromJson(jsonResponse);
      } else {
        print('Error deleting charger!');
      }
    });
    return result;
  }

  static Charger? putCharger(int id, Map<String, dynamic> jsonMap) {
    Charger? result;
    BackendService.put('chargers/$id/', jsonMap).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        result = Charger.fromJson(jsonResponse);
      } else {
        print('Error updating charger!');
      }
    });
    return result;
  }

  static List<SpeedType>? getSpeeds() {
    List<SpeedType>? result = [];
    BackendService.get('chargers/speed/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => SpeedType.fromJson(e)).toList();
      } else {
        print('Error getting speeds!');
      }
    });
    return result;
  }

  static List<CurrentType>? getCurrents() {
    List<CurrentType>? result = [];
    BackendService.get('chargers/current/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => CurrentType.fromJson(e)).toList();
      } else {
        print('Error getting currents!');
      }
    });
    return result;
  }

  static List<ConnectionType>? getConnections() {
    List<ConnectionType>? result = [];
    BackendService.get('chargers/connection/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => ConnectionType.fromJson(e)).toList();
      } else {
        print('Error getting connections!');
      }
    });
    return result;
  }
}

