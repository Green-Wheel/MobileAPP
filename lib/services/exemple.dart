import 'dart:async';

import 'package:http/http.dart' as http;

Future<String> exampleApi(String orgid) async {
  http.Response response = await http.get(
    Uri.parse("https://www.example.com/api"),
  );
  print("Respone ${response.body.toString()}");
  return response.body;
}
