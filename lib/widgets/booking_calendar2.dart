import 'dart:core';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:greenwheel/services/backendServices/publications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'custom_calendar.dart';
import 'hour_list.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//ASK: que pasa si se reservan de 23:00 a 2am por ejemplo?



void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: BookingCalendar(id: 417),
    );
  }
}

class BookingCalendar extends StatefulWidget {
  Map<String, dynamic> data = Map();
  bool waitingBakendForHourAvailability = true;
  int id;
  DateTime selectedDate = DateTime.now();
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
          SizedBox(height: MediaQuery.of(context).size.height*0.04),
          customCalendar(get_selected_date: getDateFromCalendar),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200,
                    blurRadius:10 ,
                    spreadRadius: 1,
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
                    "Horas disponibles",
                    style: TextStyle(
                        color: Color(0xA0052e42),
                        fontSize: 18
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      (widget.selectedDate.isToday())?
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
          widget.waitingBakendForHourAvailability?
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70
                ),
                child: Center(
                  child:  LoadingAnimationWidget.discreteCircle(
                      color: Colors.green.shade50,
                      size: 70,
                      secondRingColor: Colors.green.shade200,
                      thirdRingColor: Color(0x10052e42)),
                ),
              )
            ):

          Expanded(
            child:
              Column(
                children: [
                  hourList(showHoursStartingAtCurrentHour: widget.selectedDate.isToday(),reservations: widget.datesState.getMyReservationsAt(widget.selectedDate),
                          blockedHours: widget.datesState.getBlockedHours(widget.selectedDate),
                          return_change_in_reservations: updateWithHourListReservation,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: ElevatedButton(

                      onPressed: (){
                        applyToBackend();
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width*1, 40),
                        maximumSize: Size(MediaQuery.of(context).size.width*1, double.infinity),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(
                                width: 0,
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
                                fontSize: 20
                            ),

                          ),
                          Icon(Icons.event_available,size: 22,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }

  ///###########################--Widget Functions--############################

  //---------------------------------[ BACKEND ]------------------------------//


  Future<List> getAvailabilityFromBackend(DateTime date) async {
    //List<>BookingService.getBookingHours(widget.id);
    widget.data['id'] = widget.id;
    widget.data['year'] = date.year;
    widget.data['month'] = date.month;
    widget.data['day'] = date.day;
    log("-------@@@@@@@@–2--------ABAJHBDKJABDJAHDBAKJHDBAKSJHDB:    LA FECHA ${date.month}");
    List? backendHours = await PublicationService.getBlockedHoursByDay(widget.data);

    List<DateTime> blockedHours=[];
    List<DateTime> myReservedHours=[];
    //parseBackendHours(bloquedHours);
    for(var hour in backendHours!){
      var occupation = Occupation.fromJson(date, hour);
      log("Occupatttttttion@@@@@@@@@@@@@@"+occupation.toString());
      log(occupation.split(Duration(minutes: 30)).toString());
      List<DateTime> dateTimeChunks = occupation.split(Config.minTimeOfReservation);

      if(occupation.belongsToUserWithId(1)) {
        myReservedHours.addAll(dateTimeChunks);
      }
      else{
        blockedHours.addAll(dateTimeChunks);
      }

    }

    log(PublicationService.getBlockedHoursByDay(widget.data).toString());
    return [myReservedHours,blockedHours];
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
    else{
      log("Ha habido un error al aplicar los cambios al backend");
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

  Future<void> backendInitState() async {
    widget.waitingBakendForHourAvailability = true;
    var now = DateTime.now();
    List availability = await getAvailabilityFromBackend(now);
    List<DateTime> reservations = availability[0];
    List<DateTime> blockedDates = availability[1];

    log("ESTAS DEBERIAN BLOQUEARSE $blockedDates");
    widget.selectedDate = DateTime(now.year,now.month,now.day);

    initDateState(blockedDates,reservations);
    initBackendOperations(reservations);
    widget.waitingBakendForHourAvailability = false;
    setState(() {

    });
  }

  @override
  void initState() {

    var now = DateTime.now();
    backendInitState();
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
      log(dateState.toString());
      log("${DateFormat('yyyy-MM-dd').format(dateState.date)} == ${DateFormat('yyyy-MM-dd').format(date)}");
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


///################################-- Models --#################################

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
      log("Tu atecion !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      return (booking!=null && booking.id == id);
  }
}


class Booking {
  Booking({
    required this.id,
    required this.user,
    this.publication,
  });

  int id;
  User user;
  dynamic publication;

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    user: User.fromJson(json["user"]),
    publication: json["publication"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "publication": publication,
  };
}

class User {
  User({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  int id;
  String username;
  var firstName;
  var lastName;
  dynamic profilePicture;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "profile_picture": profilePicture,
  };
}


///###########################-- Class Extensions --############################

extension DatetimeExtension on DateTime {
  TimeOfDay toTimeOfDay(){
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool isToday(){
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now) ==
        DateFormat('yyyy-MM-dd').format(this);
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

