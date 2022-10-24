import '../services/google_service.dart';

class AdressAutocompletation {
  static List<String> getAdresses(String input) {
    List<String> adresses = [];
    GoogleService.getAutocomplete(input).then((response) {
      if (response['status'] == 'OK') {
        final predictions = response['predictions'];
        for (var i = 0; i < predictions.length; i++) {
          adresses.add(predictions[i]['description']);
        }
      }
    });
    return adresses;
  }
}
