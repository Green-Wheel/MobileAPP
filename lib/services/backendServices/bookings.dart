import 'dart:convert';

import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';


class BookingService {
  static List<Booking>? getBookings() {
    List<Booking> bookingList = [];
    BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        List<Booking> bookings = jsonResponse.map((e) => Booking.fromJson(e)).toList();
        print(bookings);
        bookingList = bookings;
      } else {
        print('Error getting bookings!');
      }
    });
    return bookingList;
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
