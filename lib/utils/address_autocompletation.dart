import '../services/google_service.dart';

class AdressAutocompletation {
  static Future<List<String>> getAdresses(String input) async {
    List<String> adresses = [];
    var response = await GoogleService.getAutocomplete(input);
    final predictions = response['predictions'];
    for (var i = 0; i < predictions.length; i++) {
      adresses.add(predictions[i]['description']);
    }
    print(adresses);
    print(input);
    return adresses;
  }
}
