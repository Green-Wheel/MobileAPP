import 'dart:core';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:greenwheel/services/backendServices/publications.dart';
import 'package:greenwheel/widgets/Bookings/utils/backendOperations.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/DateTimeExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/TimeOfDayExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/dateStates.dart';
import 'package:greenwheel/widgets/Bookings/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../custom_calendar.dart';
import 'configs/booking_calendar_config.dart';
import 'hour_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'models/occupation.dart';
import 'models/bookings.dart';

//ASK: que pasa si se reservan de 23:00 a 2am por ejemplo?
//TODO: al cambiar de fecha antes de que carguen las horas no se lanza la nueva query
//TODO: cuidado con recibir reservas invalidas desde backend

void main() => runApp(const MyApp());

//TODO: exportar colores
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking calendar',
      home: BookingCalendar(id: 432),
    );
  }
}

class BookingCalendar extends StatefulWidget {
  Map<String, dynamic> data = Map();
  bool waitingBakend = true;
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
                    color: Colors.blue.shade100,
                    blurRadius:10 ,
                    spreadRadius: 1,
                    offset: Offset(0, 7),
                  ),
                ],
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Horas:",
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
                      "Hoy": widget.selectedDate.isTomorrow()?"Mañana":
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
          widget.waitingBakend?
          Expanded(
              child: Container(
                decoration: const BoxDecoration(
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
                (widget.selectedDate.hasPast())?
                const Expanded(
                  child: Center(
                    child: Text(
                      'No se puede reservar en una fecha pasada',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15
                      ),
                    ),
                  ),
                ):
                hourList(
                  showHoursStartingAtCurrentHour: widget.selectedDate.isToday(),
                  reservations: widget.datesState.getMyReservationsAt(widget.selectedDate),
                  blockedHours: widget.datesState.getBlockedHours(widget.selectedDate),
                  return_change_in_reservations: updateWithHourListReservation,

                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: ElevatedButton(

                        onPressed: (){
                          if(widget.backendOperations.getNumberOfOperationsOfType(OperationType.block) > 0) {

                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Row(
                                  children: const [
                                    Icon(Icons.warning_rounded, color: Colors.amber,),
                                    Text(' Deshacer cambios'),
                                  ],
                                ),
                                content: const Text('Se deseleccionarán todas las horas que has marcado'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Ok');
                                      widget.datesState.reset();
                                      widget.backendOperations.reset();
                                      updateAvailabilityWithBackend(widget.selectedDate);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width*0.45, 40),
                          maximumSize: Size(MediaQuery.of(context).size.width*0.5, double.infinity),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: const BorderSide(
                                  width: 0,
                                  color: Color(0xA0052e42)
                              )
                          ),
                          backgroundColor:  Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.refresh_rounded,size: 22,color: Color(0xA0052e42),),
                            Text(
                              " Desmarcar",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xA0052e42),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: ElevatedButton(

                        onPressed: () async {
                          log("################################################# Bloquear ################################  ");
                            widget.backendOperations.setBlockingRepeatMode(1);
                          if(widget.backendOperations.getNumberOfOperationsOfType(OperationType.block) > 0) {
                            if (!await widget.backendOperations.applyBackendOperations()) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: Row(
                                        children: const [
                                          Icon(Icons.error,
                                            color: Colors.redAccent,),
                                          Text(' Error al guardar'),
                                        ],
                                      ),
                                      content: const Text(
                                          'Ha habido un error al guardar los cambios. Por favor, ponte en contacto con los GreenWheelers para que lo solucionen'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(
                                                  context, 'Entendido'),
                                          child: const Text('Entendido'),
                                        ),
                                      ],
                                    ),
                              );
                            }

                            else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: Row(
                                        children: const [
                                          Icon(Icons.check_circle,
                                            color: Colors.green,),
                                          Text(' Cambios guardados'),
                                        ],
                                      ),
                                      content: const Text(
                                          '¡Se han guardado tus horas bloqueadas!'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Ok');
                                            updateAvailabilityWithBackend(
                                                widget.selectedDate);
                                          },
                                          child: const Text('Ok'),
                                        ),

                                      ],
                                    ),
                              );

                            }
                            widget.backendOperations.reset();
                            log("lookhiar" + widget.backendOperations
                                .getNumberOfOperationsOfType(
                                OperationType.block).toString());
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width*0.45, 40),
                          maximumSize: Size(MediaQuery.of(context).size.width*0.5, double.infinity),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: BorderSide(
                                  width: 0,
                                  color: Colors.green.shade800
                              )
                          ),
                          backgroundColor:  Colors.blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.block,size: 22,),
                            Text(
                              " Bloquear ",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
    List? backendHours = await PublicationService.getBlockedHoursByDay(widget.data);

    List<DateTime> blockedHours=[];
    List<DateTime> myReservedHours=[];
    //parseBackendHours(bloquedHours);
    for(var hour in backendHours!){
      var occupation = Occupation.fromJson(date, hour);
      log("Occupation: "+occupation.toString());
      log(occupation.split(Config.minTimeOfReservation).toString());
      List<DateTime> dateTimeChunks = occupation.split(Config.minTimeOfReservation);


      blockedHours.addAll(dateTimeChunks);

    }

    log(PublicationService.getBlockedHoursByDay(widget.data).toString());
    return [myReservedHours,blockedHours];
  }

  Future<void> updateAvailabilityWithBackend(DateTime date) async {
    widget.waitingBakend = true;
    log("antes el checkpoint");
    List availability = await getAvailabilityFromBackend(date);
    List<DateTime> reservations = availability[0];
    List<DateTime> blockedDates = availability[1];

    log("ESTAS DEBERIAN BLOQUEARSE $blockedDates");

    widget.datesState.update(reservations, blockedDates);
    log("ha pasado el checkpoint");
    //widget.backendOperations.update();
    widget.waitingBakend = false;
    setState(() {

    });
  }
  //--------------------------------[ CALLBACKS ]-----------------------------//
  //callbacks custom_calendar
  void getDateFromCalendar(DateTime date){
    setState(() {
      widget.selectedDate = date;
      updateAvailabilityWithBackend(date);
      log("dia seleccionado: $date");
    });
  }

  //callbacks hour_list
  void updateWithHourListReservation(TimeOfDay reservation, OperationType operation)
  {
    operation = (operation == OperationType.add)?OperationType.block: OperationType.nothing;
    Availability availability =
    (operation == OperationType.add)?
    Availability.reserved:Availability.available;

    DateTime date = DateTime(
        widget.selectedDate.year,
        widget.selectedDate.month,
        widget.selectedDate.day,
        reservation.hour,
        reservation.minute);
    log("################################################## EL FALLOTRON ${date}");
    widget.datesState.add(reservation.toDateTime(widget.selectedDate),availability);
    widget.backendOperations.add(date,operation,widget.id);
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


  void updateDateState(List<DateTime> blockedDates, List<DateTime> reservations){

    log("ejecutando init--------------");

    widget.datesState.update(reservations,blockedDates);
  }



  void updateBackendOperations(List<DateTime> blockedDates, List<DateTime> reservations){

    log("ejecutando init--------------");

    widget.datesState.update(reservations,blockedDates);
  }

  //--------------------------------[ OVERRIDES ]-----------------------------//

  @override
  void initState() {
    log(widget.id.toString());
    widget.datesState = DateStates([], []);
    widget.backendOperations = BackendOperations([], widget.id);
    updateAvailabilityWithBackend(DateTime.now());
    super.initState();

  }

}