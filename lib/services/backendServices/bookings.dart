import 'dart:convert';
import 'dart:developer';
import 'package:greenwheel/services/backend_service.dart';
import '../../serializers/bookings.dart';


class BookingService {
  static Future<List<Booking>> getBookings() async {
    List<Booking> result = [];
    await BackendService.get('bookings/').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('bookings json $jsonResponse');
        List<dynamic> bookings = jsonResponse['results'] as List<dynamic>;
        print('bookings json $bookings');
        result = bookings.map((e) => Booking.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting bookings!');
      }
    });
    return result;
  }

  static List<DateTime> splitHours(){
    return [];
  }

  static Future<List<DateTime>> getBookingHours(int id) async {
    late List<DateTime> hours=[];
    await BackendService.get('bookings/$id').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        log('bookings json $jsonResponse');
        dynamic bookingJson = jsonResponse['results'];
        log('bookings json $bookingJson');
        Booking booking = Booking.fromJson(bookingJson);
        log(booking.toString());


      } else {
        log('Error getting bookings!');
      }
    });
    return [];
  }

  static Future<List<Booking>> getBookingsOrderedBy(String orderBy) async {
    List<Booking> result = [];
    await BackendService.get('bookings/?orderby=$orderBy').then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('bookings json $jsonResponse');
        List<dynamic> bookings = jsonResponse['results'] as List<dynamic>;
        print('bookings json $jsonResponse');
        result = bookings.map((e) => Booking.fromJson(e)).toList();
        print(result);
      } else {
        print('Error getting bookings!');
      }
    });
    return result;
  }

  static Future<bool> newBooking(Map<String, dynamic> data) async {
    try {
      var response = await BackendService.post('bookings/', data);
      return response.statusCode == 200;
    } catch (e) {
      log(e.toString());
      return false;
    }
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
