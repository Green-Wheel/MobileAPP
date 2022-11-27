import 'dart:core';
import 'dart:developer';
import 'package:greenwheel/services/backendServices/bookings.dart';
import 'package:greenwheel/services/backendServices/publications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';

void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: BookingCalendar(id: 1),
    );
  }
}

class BookingCalendar extends StatefulWidget {
  int id;
  late DateTime selectedDate;
  late DateStates datesState;
  late BackendOperations backendOperations;
  BookingCalendar({Key? key, required this.id}) : super(key: key);

  @override
  State<BookingCalendar> createState() => BookingCalendarState();
}

class BookingCalendarState extends State<BookingCalendar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          customCalendar(get_selected_date: getDateFromCalendar),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 8,
                    spreadRadius: 4,
                    offset: Offset(0, 10),
                  ),
                ],
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Horas disponibles:",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(widget.selectedDate) ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())?
                      "Hoy":
                      DateFormat('dd · MM · yyyy').format(widget.selectedDate).toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          hourList(reservations: widget.datesState.getMyReservationsAt(widget.selectedDate),
                  availableHours: widget.datesState.getAvailableHours(widget.selectedDate),
                  return_change_in_reservations: updateWithHourListReservation,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: ElevatedButton(

              onPressed: (){
                applyToBackend();
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width*1, 50),
                maximumSize: Size(MediaQuery.of(context).size.width*1, double.infinity),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(
                        width: 2,
                        color: Colors.green.shade800
                    )
                ),
                backgroundColor:  Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Reservar ",
                    style: TextStyle(
                        fontSize: 22
                    ),

                  ),
                  Icon(Icons.event_available,size: 25,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///###########################--Widget Functions--############################

  //---------------------------------[ BACKEND ]------------------------------//

  List getHourAvailabilityFromBackend() {

    return [];
  }


  //--------------------------------[ CALLBACKS ]-----------------------------//
  //callbacks custom_calendar
  void getDateFromCalendar(DateTime date){
    setState(() {
      widget.selectedDate = date;
      log("dia seleccionado: $date");
    });
  }

  //callbacks hour_list
  void updateWithHourListReservation(TimeOfDay reservation, Operation operation)
  {
    Availability availability =
      (operation == Operation.add)?
      Availability.reserved:Availability.available;
    widget.datesState.add(reservation.toDateTime(widget.selectedDate),availability);
    widget.backendOperations.add(reservation.toDateTime(widget.selectedDate),operation);
  }

  //----------------------------------[ UTILS ]-------------------------------//

  List<DateTime> convertToDateTime(List<TimeOfDay> hours,DateTime date){
    List<DateTime> dates = [];
    for(var hour in hours)
    {
      dates.add(hour.toDateTime(date));
    }
    return dates;
  }

  void applyToBackend(){
    widget.backendOperations.mergeBackendOperations();
    if(widget.backendOperations.applyBackendOperations()){
      log("Se han aplicado correctamente los cambios al backend");
    }

  }

  void initDateState(List<DateTime> blockedDates, List<DateTime> reservations){

    log("ejecutando init--------------");
    widget.datesState = DateStates(reservations, blockedDates);
  }

  void initBackendOperations(List<DateTime> reservations){

    widget.backendOperations = BackendOperations(reservations);

  }

  //--------------------------------[ OVERRIDES ]-----------------------------//

  @override
  void initState() {
    var now = DateTime.now();
    List<DateTime> blockedDates = [];
    List<DateTime> reservations =  [DateTime(now.year,now.month,now.day,now.hour,0),DateTime(now.year,now.month,now.day+1,now.hour,0),DateTime(now.year,now.month,now.day,now.hour,30),DateTime(now.year,now.month,now.day,now.hour+1,0),];//PublicationService.getBlockedHoursByDay(widget.selectedDate);

    widget.selectedDate = DateTime(now.year,now.month,now.day);
    initDateState(blockedDates,reservations);
    initBackendOperations(reservations);

    super.initState();
  }

}
///#################################-- Enums --#################################

enum Operation {
  add,
  delete,
  nothing
}

enum Availability {
  blocked,
  available,
  reserved
}

///################################-- Classes --################################

class DateState{
  late DateTime date;
  late Availability availability;
  // constructor
  DateState(this.date, this.availability);

  @override
  String toString(){
    String s = "Time-> $date Type-> $availability";
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
      if(dateStates[i].availability != Availability.blocked) {
        dateStates.removeAt(i);
      }
    }
  }

/*  void addAll(List<DateTime> dates, Availability availability){
    for (var date in dates){
      add(date, availability);
    }
  }*/

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
      if(DateFormat('yyyy-MM-dd').format(dateState.date) ==
         DateFormat('yyyy-MM-dd').format(date)) {
        dateStatesAtDate.add(dateState);
      }
    }
    return dateStatesAtDate;
  }

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

  static List<DateState> generateStates(List<DateTime> reservations, List<DateTime> blocked){
    List<DateState> dateStates=[];
    for( var date in reservations ) {
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

}

class BackendOperations{  
  
  List<BackendOperation> backendOperations = [];

  bool applyBackendOperations() {
    for(var backendOperation in backendOperations){
      if(backendOperation.operation==Operation.add){
        log(backendOperation.toString());
      }
      if(backendOperation.operation==Operation.delete){
        log(backendOperation.toString());
      }
    }

    return true;
  }

  void orderByDateBackendOperations(){
    backendOperations.sort((a,b) => a.compareTo(b));
    log("BackendOperations ordenado ------> $backendOperations");
  }

  void mergeBackendOperations(){
    if(backendOperations.isEmpty) return;
    orderByDateBackendOperations();


    List<BackendOperation> toRemove=[];

    var resizeBackendOperation = backendOperations[0];
    for(int i=1; i < backendOperations.length; ++i){
      var current = backendOperations[i];
      log("current: $current");
      log("resizing: $resizeBackendOperation");
      if(current.operation != Operation.nothing &&
          resizeBackendOperation.isContiguousWith(current) &&
          resizeBackendOperation.operation == current.operation){

        resizeBackendOperation.endDate = current.endDate;
        log("[$i] resized es ahora--->$resizeBackendOperation");
        toRemove.add(current);
      }
      else{
        resizeBackendOperation = backendOperations[i];
      }
    }
    log(toRemove.toString());
    for(var backendOperation in toRemove){
      backendOperations.remove(backendOperation);
    }
    log("[-BACKEND OPERATIONS COMPRESSED-]\n $backendOperations");
  }

  bool backendOperationContains(DateTime date)
  {
    for(var backendOperation in backendOperations){
      if(backendOperation.contains(date)) return true;
    }
    return false;
  }

  int backendOperationsIndexOf(DateTime date){
    int index = -1;
    int len = backendOperations.length;
    for(int i=0; i < len; ++i){
      index=i;
      if(backendOperations[i].contains(date)) return index;
    }
    return index;
  }
  
  void add(DateTime date, Operation operation){
  
    if(!backendOperationContains(date))
    {
      log("Añadiendo a backend operations ---------$date");
      var backendOperation  = BackendOperation(date,
          date.add(Config.minTimeOfReservation - const Duration(minutes: 1)),
          operation);
      backendOperations.add(backendOperation);
    }
    else{
      int i = backendOperationsIndexOf(date);
      if(backendOperations[i].operation == Operation.nothing) {
        backendOperations[i].operation = operation;
      }
      else{
        backendOperations.removeAt(i);
      }
    }
    log("[-Backend Operations-]\n $backendOperations");
  }

  BackendOperations(List<DateTime> reservations){
    for(var reservation in reservations){
      add(reservation, Operation.nothing);
    }
  }
}

class BackendOperation{
  late DateTime startDate;
  late DateTime endDate;

  late Operation operation;

  bool contains(DateTime date){
    return ( date >= startDate && date < endDate );
  }

  bool isContiguousWith(BackendOperation b){
    bool contiguous = endDate.difference(b.startDate).inMinutes.abs() <= Config.minTimeOfReservation.inMinutes;
    log("iscontigousu ---->diference ${endDate.difference(b.startDate).inMinutes.abs()} <= ${Config.minTimeOfReservation.inMinutes} | ${(contiguous)?"Si":"No"}");

    return contiguous;
  }

  @override
  String toString(){
    return "BackendOperation: $startDate ->$endDate | [$operation]\n";
  }

  @override
  int compareTo(BackendOperation b){
    //log("Comparación: ${startDate.compareTo(b.startDate)} + ${startDate.toTimeOfDay().compareTo(b.startDate.toTimeOfDay())}");
    return startDate.compareTo(b.startDate)*2 +
        startDate.toTimeOfDay().compareTo(b.startDate.toTimeOfDay());
  }

  BackendOperation(this.startDate, this.endDate, this.operation);
}

class Config{
  static Duration minTimeOfReservation = const Duration(minutes: 30);
  static TimeOfDay hourListFirstHour = const TimeOfDay(hour: 7, minute: 0);
  static TimeOfDay startingHour = const TimeOfDay(hour: 0, minute: 0);
  static TimeOfDay endingHour = const TimeOfDay(hour: 23, minute: 59);
}

///###########################-- Class Extensions --############################

extension DatetimeExtension on DateTime {
  TimeOfDay toTimeOfDay(){
    return TimeOfDay(hour: hour, minute: minute);
  }




  bool operator >= (DateTime b)
  {
    return compareTo(b) == 1 || compareTo(b) == 0;
  }

  bool operator <= (DateTime b)
  {
    return compareTo(b) == -1 || compareTo(b) == 0;
  }

  bool operator > (DateTime b)
  {
    return compareTo(b) == 1;
  }

  bool operator < (DateTime b)
  {
    return compareTo(b) == -1;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  DateTime toDateTime(date){
    return DateTime( date.year, date.month, date.day, hour, minute);
  }

  TimeOfDay operator + (TimeOfDay b)
  {
    int hoursSum = hour + b.hour;
    int minutesSum = minute + b.minute;
    return TimeOfDay(hour: hoursSum%24 + ((minutesSum)/60).floor(),
                     minute: (minutesSum)%60);
  }

  TimeOfDay operator - (TimeOfDay b)
  {
    return TimeOfDay(hour: hour - b.hour, minute: minute - b.minute);
  }

  int compareTo(TimeOfDay b) {
    if (hour < b.hour) return -1;
    if (hour > b.hour) return 1;
    if (minute <  b.minute) return -1;
    if (minute > b.minute) return 1;
    return 0;
  }

  bool operator >= (TimeOfDay b)
  {
    return compareTo(b) == 1 || compareTo(b) == 0;
  }

  bool operator <= (TimeOfDay b)
  {
    return compareTo(b) == -1 || compareTo(b) == 0;
  }

  bool operator > (TimeOfDay b)
  {
    return compareTo(b) == 1;
  }

  bool operator < (TimeOfDay b)
  {
    return compareTo(b) == -1;
  }
}
