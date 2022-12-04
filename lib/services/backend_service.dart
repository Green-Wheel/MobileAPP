import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'generalServices/LoginService.dart';

class BackendService {
  // Variable en el .env con la dirección del backend. Ejemplo: BACKEND_API_URL=http://54.72.13.162:80/api/
  static final String _baseUrl = 'http://54.72.13.162:80/api/';
  static final _loggedInStateInfo = LoginService();

  /// Permite hacer un get genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el get (ejemplo: users/language/?id=1)
  /// @return: Devuelve un Future con el resultado del get, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> get(String endpoint) async {
    var apiKey = _loggedInStateInfo.apiKey;
    apiKey ??= "";
    print(_baseUrl + endpoint);
    http.Response response = await http.get(
      Uri.parse(_baseUrl + endpoint),
      headers: {"Accept": "application/json", "API-KEY": apiKey},
    );
    return response;
  }

  /// Permite hacer un post genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el post (ejemplo: users/language/)
  /// @param jsonMap: Mapa con los datos que se quieren enviar en el post en formato clave valor. Ejemplo: {"language": "es"}
  /// @return: Devuelve un Future con el resultado del post, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> post(String endpoint,
      Map<String, dynamic> jsonMap) async {
    var apiKey = _loggedInStateInfo.apiKey;
    apiKey ??= "";
    print(_baseUrl + endpoint);
    http.Response response = await http.post(
      Uri.parse(_baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "API-KEY": apiKey
      },
      body: jsonEncode(jsonMap),
    );
    return response;
  }

  /// Permite hacer un put genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el put (ejemplo: users/1/)
  /// @param jsonMap: Mapa con los datos que se quieren enviar en el put en formato clave valor. Ejemplo: {"language": "es"}
  /// @return: Devuelve un Future con el resultado del put, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> put(String endpoint,
      Map<String, dynamic> jsonMap) async {
    var apiKey = _loggedInStateInfo.apiKey;
    apiKey ??= "";
    print(Uri.parse(_baseUrl + endpoint));
    http.Response response = await http.put(
      Uri.parse(_baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "API-KEY": apiKey
      },
      body: jsonEncode(jsonMap),
    );
    return response;
  }

  /// Permite hacer un delete genérico a cualquier endpoint de la api
  /// @param endpoint: Endpoint al que se quiere hacer el post (ejemplo: users/1/)
  /// @return: Devuelve un Future con el resultado del delete, al cual se le debe hacer un then para obtener el resultado
  static Future<http.Response> delete(String endpoint) async {
    var apiKey = _loggedInStateInfo.apiKey;
    apiKey ??= "";
    http.Response response = await http.delete(
      Uri.parse(_baseUrl + endpoint),
      headers: {"Accept": "application/json", "API-KEY": apiKey},
    );
    return response;
  }

  ///Permite enviar ficheros a qualquier endpoint de la api
  ///@param endpoint: Endpoint al que se quiere hacer el post (ejemplo: users/1/)
  ///@param List<File> files: Lista de ficheros que se quieren enviar
  static Future<http.StreamedResponse> postFiles(String endpoint,
      List<File> files) async {
    var apiKey = _loggedInStateInfo.apiKey;
    apiKey ??= "";
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + endpoint));
    request.headers.addAll({"API-KEY": apiKey});
    for (var file in files) {
      request.files.add(await http.MultipartFile.fromBytes(
          'file', file.readAsBytesSync(),
          filename: file.path.split('/').last));
    }
    var response = await request.send();
    return response;
  }
}
