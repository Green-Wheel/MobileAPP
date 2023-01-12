import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/DateTimeExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/TimeOfDayExtension.dart';

import '../configs/booking_calendar_config.dart';
import 'enums.dart';

class DateState{
  late DateTime date;
  late Availability availability;
  // constructor
  DateState(this.date, this.availability);

  @override
  String toString(){
    String s = "(Time-> $date Type-> $availability)";
    return s;
  }
}

class DateStates{
  late List<DateState> dateStates;

  bool dateStatesContains(DateTime date)
  {
    for(var dateState in dateStates){
      if(dateState.date == date) return true;
    }
    return false;
  }

  void update(List<DateTime> reservations, List<DateTime> blockeds){
    for (var reservation in reservations){
      add(reservation, Availability.reserved);
    }
    for (var blocked in blockeds){
      add(blocked, Availability.blocked);
    }
  }

  int dateStatesIndexOf(DateTime date){
    int index = -1;
    int len = dateStates.length;
    for(int i=0; i < len; ++i){
      index=i;
      if(dateStates[i].date == date) return index;
    }
    return index;
  }
//TODO: controlar el tipo que se añade y su operación de backend.
  void add(DateTime date, Availability availability){

    if(!dateStatesContains(date)) {
      DateState dateState = DateState(date, availability);
      dateStates.add(dateState);
    }
    else {
      int i = dateStatesIndexOf(date);
      if(availability == Availability.blocked){
        dateStates[i].availability = availability;
      }
      if(dateStates[i].availability != Availability.blocked ) {
        dateStates.removeAt(i);
      }
    }
  }

  List<TimeOfDay> getMyReservationsAt(DateTime date){
    List<TimeOfDay> reservations=[];
    List<DateState> dateStatesAtDate = getDateStatesAt(date);
    for (var dateState in dateStatesAtDate)
    {
      TimeOfDay time = TimeOfDay(hour: dateState.date.hour, minute: dateState.date.minute);
      reservations.add(time);
    }
    return reservations;
  }

  List<DateState> getDateStatesAt(DateTime date) {
    List<DateState> dateStatesAtDate = [];
    for (var dateState in dateStates){
      log(dateState.toString());
      //log("${DateFormat('yyyy-MM-dd').format(dateState.date)} == ${DateFormat('yyyy-MM-dd').format(date)}");
      if(DateFormat('yyyy-MM-dd').format(dateState.date) == DateFormat('yyyy-MM-dd').format(date)) {
        log("Se ha añadido");
        dateStatesAtDate.add(dateState);
      }
      else{
        log("NO se ha añadido");
      }
    }
    return dateStatesAtDate;
  }

  //TODO: no tiene en cuenta las horas bloqueadas, añade todas como disponibles
  List<TimeOfDay> getAvailableHours(DateTime date) {
    List<TimeOfDay> availableHours = [];
    Duration step = Config.minTimeOfReservation;
    DateTime startHour = Config.startingHour.toDateTime(date);
    DateTime endHour = Config.endingHour.toDateTime(date);

    for(DateTime hour = startHour; hour < endHour; hour = hour.add(step))
    {
      availableHours.add(hour.toTimeOfDay());
    }

    return availableHours;
  }

  //TODO: no tiene en cuenta las horas bloqueadas, añade todas como disponibles
  List<TimeOfDay> getBlockedHours(DateTime date) {
    List<DateState> dateStatesAtDate = getDateStatesAt(date);
    log("Lo que pillas en la fecha $dateStatesAtDate");
    List<TimeOfDay> blockedHours = [];
    for(var dateState in dateStatesAtDate){
      log(dateState.availability.toString());
      if(dateState.availability==Availability.blocked ) {
        blockedHours.add(dateState.date.toTimeOfDay());
      }
    }
    log("ESTO ES LO QUE LE ENVIAS AL HOURLIST $date --> $blockedHours");
    return blockedHours;
  }

  static List<DateState> generateStates(List<DateTime> reservations, List<DateTime> blocked){
    List<DateState> dateStates=[];

    for( var date in reservations ) {
      if(!blocked.contains(date))
        dateStates.add(DateState(date,Availability.reserved));
    }
    for( var date in blocked ) {
      dateStates.add(DateState(date,Availability.blocked));
    }
    return dateStates;
  }

/*  static List<TimeOfDay> getHours(List<DateState> dateStates){
    List<TimeOfDay> hours=[];
    for( DateState dateState in dateStates ) {
      hours.add(TimeOfDay(hour: dateState.date.hour, minute: dateState.date.minute));
    }

    return hours;
  }*/

  DateStates(List<DateTime> reservations, List<DateTime> blocked ){
    log(blocked.toString());
    dateStates = DateStates.generateStates(reservations, blocked);
    log(toString());
  }

  @override
  String toString(){
    String s="[-DateStates-]\n";
    for(var elem in dateStates){
      s+="$elem\n";
    }
    return s;
  }

  void reset() {
    dateStates = [];
  }
}
