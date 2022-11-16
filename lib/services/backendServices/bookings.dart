import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';


class BookingService {
  static Future<List?> getBookings() async {
    List result = [];
    await BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        result = jsonResponse;
      } else {
        print('Error getting bookings!');
      }
    });
    return result;
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
