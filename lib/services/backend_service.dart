import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class BackendService {
  // Variable en el .env con la dirección del backend. Ejemplo: BACKEND_API_URL=http://192.168.56.1:8000/api/
  static String _baseUrl = FlutterConfig.get('BACKEND_API_URL');

  /// Permite hacer un get genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el get (ejemplo: users/language/?id=1)
  /// @return: Devuelve un Future con el resultado del get, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> get(String endpoint) async {
    print(_baseUrl + endpoint);
    http.Response response = await http.get(
      Uri.parse(_baseUrl + endpoint),
      headers: {"Accept": "application/json"},
    );
    return response;
  }

  /// Permite hacer un post genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el post (ejemplo: users/language/)
  /// @param jsonMap: Mapa con los datos que se quieren enviar en el post en formato clave valor. Ejemplo: {"language": "es"}
  /// @return: Devuelve un Future con el resultado del post, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> jsonMap) async {
    print(_baseUrl + endpoint);
    http.Response response = await http.post(
      Uri.parse(_baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(jsonMap),
    );
    return response;
  }

  /// Permite hacer un put genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el put (ejemplo: users/1/)
  /// @param jsonMap: Mapa con los datos que se quieren enviar en el put en formato clave valor. Ejemplo: {"language": "es"}
  /// @return: Devuelve un Future con el resultado del put, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> put(
      String endpoint, Map<String, dynamic> jsonMap) async {
    print(_baseUrl);
    http.Response response = await http.put(
      Uri.parse(_baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(jsonMap),
    );
    return response;
  }

  /// Permite hacer un delete genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el post (ejemplo: users/1/)
  /// @return: Devuelve un Future con el resultado del delete, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> delete(String endpoint) async {
    http.Response response = await http.delete(
      Uri.parse(_baseUrl + endpoint),
      headers: {"Accept": "application/json"},
    );
    return response;
  }
}