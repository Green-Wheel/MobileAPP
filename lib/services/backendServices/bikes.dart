import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';

import '../../serializers/bikes.dart';

class BikeService {
  static Future<List<Bike>> getBikes() async {
    List<Bike> result = [];
    await BackendService.get('bikes/').then((response) {
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Bike.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting bikes!');
      }
    });
    return result;
  }

  static Future<List<Bike>> getNormalBikes() async {
    List<Bike> result = [];
    await BackendService.get('bikes/?bike_type=1').then((response) { // bikes/?type=normal
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Bike.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting normal bikes!');
      }
    });
    return result;
  }

  static Future<List<Bike>> getElectricBikes() async {
    List<Bike> result = [];
    await BackendService.get('bikes/?bike_type=2').then((response) { // bikes/?type=electric
      // bikes/
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        result = jsonResponse.map((e) => Bike.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting electric bikes!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getBikeList(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('bikes/list/?page=$pag').then((response) {
      // bikes/list/?page=$pag
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('json response bicis $jsonResponse');
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        print('bikes list $bikes');
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
        print('result $result');
      } else {
        print('Error getting bike list!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getBikesListByDate(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('bikes/list/?orderby=date&page=$pag').then((response) { // per pàgines
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
      } else {
        print('Error getting ordered bike list!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getBikesListByProximity(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('bikes/list/?orderby=date&page=$pag').then((response) { // ordery by proximity
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
      } else {
        print('Error getting ordered bike list!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getNormalBikeList(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('bikes/list/?bike_type=1&page=$pag').then((response) { // per pàgines
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
      } else {
        print('Error getting ordered bike list!');
      }
    });
    return result;
  }

  static Future<List<BikeList>> getElectricBikeList(int pag) async {
    List<BikeList> result = [];
    await BackendService.get('bikes/list/?bike_type=2&page=$pag').then((response) { // per pàgines
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bikes = jsonResponse['results'] as List<dynamic>;
        result = bikes.map((e) => BikeList.fromJson(e)).toList();
      } else {
        print('Error getting ordered bike list!');
      }
    });
    return result;
  }


  static Future<DetailedBikeSerializer?> getBike(int id) async {
    DetailedBikeSerializer? result;
    var response = await BackendService.get('bikes/$id/');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      result = DetailedBikeSerializer.fromJson(jsonResponse);
    } else {
      throw Exception('Error getting bikes');
    }
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

  static Future<bool> newBike(DetailedBikeSerializer data, images) async {
    try {
      Map<String,dynamic> body = {
        'latitude': data.localization.latitude,
        'longitude': data.localization.longitude,
        'town': data.town.name,
        'province': data.town.province.name,
        'title': data.title,
        'description': data.description,
        'direction': data.direction,
        'bike_type': data.bike_type.id,
        'price': data.price,
        'power': data.power,
      };
      var response = await BackendService.post('bikes/', body);
      if (response.statusCode != 200) return false;
      var json = jsonDecode(response.body);
      var response2 = await BackendService.postFiles(
          'publications/${json['id']}/upload/', images);
      return response2.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<DetailedBikeSerializer> getBikeInfo(int id) async {
    Map<String, dynamic> result = {};
    var response = await BackendService.get('bikes/$id/');
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    } else {
      throw Exception('Error getting bike info');
    }
    return DetailedBikeSerializer.fromJson(result);
  }

  static Future<bool> updateBike(DetailedBikeSerializer data) async {
    try {
      Map<String,dynamic> body = {
        'latitude': data.localization.latitude,
        'longitude': data.localization.longitude,
        'town': data.town.name,
        'province': data.town.province.name,
        'title': data.title,
        'description': data.description,
        'direction': data.direction,
        'bike_type': data.bike_type.id,
        'price': data.price,
        'power': data.power,
      };
      var response =
          await BackendService.put('bikes/${data.id}/', body);
      if (response.statusCode != 200) return false;
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<BikeType>> getBikeTypes() async {
    try {
      List<BikeType> result = [];
      var response = await BackendService.get('bikes/types/');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse.map((e) => BikeType.fromJson(e)).toList();
      } else {
        print('Error getting bike types!');
      }
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
