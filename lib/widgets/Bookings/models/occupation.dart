import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:greenwheel/widgets/Bookings/models/bookings.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/DateTimeExtension.dart';



class Occupation {
  Occupation({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.occupationRangeType,
    this.booking,
  });

  String startTime;
  String endTime;
  int id;
  int occupationRangeType;
  var booking;

  factory Occupation.fromRawJson(DateTime date, String str) =>
      Occupation.fromJson(date, json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Occupation.fromJson(DateTime date,Map<String, dynamic> json){
    String dateString = date.toString().substring(0,
        11);

    String startT = dateString +
        json["start_time"].substring(0,
            json["start_time"].length-3);

    String endT = dateString +
        json["end_time"].substring(0,
            json["end_time"].length-3);

    return Occupation(
      startTime: startT,
      endTime: endT,
      id: json["id"],
      occupationRangeType: json["occupation_range_type"],
      booking: json["booking"] == null ? null : Booking.fromJson(
          json["booking"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "start_time": startTime,
    "end_time": endTime,
    "id": id,
    "occupation_range_type": occupationRangeType,
    "booking": booking == null ? null : booking.toJson(),
  };

  List<DateTime> split(Duration chunkTime){
    DateTime startTimeDate = DateFormat("yyyy-MM-dd HH:mm").parse(startTime);
    DateTime endTimeDate = DateFormat("yyyy-MM-dd HH:mm").parse(endTime);
    //Duration aux = Duration(hours: startTimeDate.hour, minutes: startTimeDate.minute);
    //Duration diff = DateTime.parse(endTime).difference(startTimeDate);
    //diff.inSeconds % Duration(days: startTimeDate.day)
    DateTime currentDateTime = startTimeDate;
    List<DateTime> chunks = [];
    log(currentDateTime.toString()+"  |  "+endTimeDate.toString());
    while(currentDateTime < endTimeDate)
    {

      chunks.add(currentDateTime);
      //log(currentDateTime.toString());
      currentDateTime = currentDateTime.add(chunkTime);
    }
    //log("chunks"+chunks.toString());
    return chunks;
  }

  @override
  String toString() {

    return startTime.toString()+" -> "+endTime.toString();
  }

  bool belongsToUserWithId(int id) {
    //log("Tu atecion !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return (booking!=null && booking.id == id);
  }
}
