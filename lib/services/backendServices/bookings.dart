import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';

class BookingService {
  static List<Booking>? getBookings() {
    BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        // Bookings = List<Booking>
        Booking bookings = jsonResponse.map((e) => Booking.fromJson(e)).toList();

        //List<Booking> bookings = jsonResponse.map((e) => Booking.fromJson(e)).toList();
        //List temp = (jsonResponse as List).map((e) => Booking.fromJson(e)).toList();
        //print(temp);

        //Map<String, dynamic> map = json.decode(response.body);
        //print(map[0]['created']);
        // List<dynamic> list = map.toList();
        // List<dynamic> data = map["id"];
        // print(data[0]["id"]);
        //List<dynamic> bookings = Booking.fromJson(jsonResponse) as List<dynamic>;
        print(bookings);
        return bookings;
      } else {
        print('Error getting bookings!');
      }
    });
  }

  static bool deleteBookings(id) {
    BackendService.delete('bookings/$id/').then((response) {
      if (response.statusCode == 204) {
        print('Booking cancelled!');
        return true;
      } else {
        print('Error deleting booking!');
        print(response.statusCode);
        return false;
      }
    });
    return false;
  }
}