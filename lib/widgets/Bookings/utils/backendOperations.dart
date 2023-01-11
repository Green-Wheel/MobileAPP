import 'dart:developer';

import 'package:greenwheel/services/backendServices/publications.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/DateTimeExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/ListExtension.dart';
import 'package:greenwheel/widgets/Bookings/utils/classExtensions/TimeOfDayExtension.dart';


import '../../../services/backendServices/bookings.dart';
import '../configs/booking_calendar_config.dart';
import 'enums.dart';

class BackendOperations{

  List<BackendOperation> backendOperations = [];
  int blocking_repeat_mode = 1;

  void setBlockingRepeatMode(int mode){
    log("setting mode repetition $mode");
    blocking_repeat_mode = mode;
  }

  Future<bool> applyBackendOperations() async {
    if(backendOperations.length <= 0) return true;
    log("Aplicando operaciones backend");
    List mergedBackendOperations = mergeBackendOperations();
    for(BackendOperation backendOperation in mergedBackendOperations){
      if(backendOperation.operation == OperationType.block){
        backendOperation.repetitionMode = blocking_repeat_mode;
      }
        if(!await backendOperation.execute()) return false;
    }
    //reset();
    return true;
  }

  void orderByDateBackendOperations(){
    backendOperations.sort((a,b) => a.compareTo(b));
    log("BackendOperations ordenado ------> $backendOperations");
  }
//TODO: Convertir a que devuelva la lista mergeada en vez de sobreescribir la original.
  List mergeBackendOperations(){
    orderByDateBackendOperations();
    List mergedBackendOperations = backendOperations.cloneBackendOperations();
    //log("@@@@@@@@@@@@@@@ ${identical(mergedBackendOperations[0],backendOperations[0] )}");
    if(backendOperations.isEmpty) return [];

    List<BackendOperation> toRemove=[];

    var resizeBackendOperation = mergedBackendOperations[0];
    for(int i=1; i < mergedBackendOperations.length; ++i){
      var current = mergedBackendOperations[i];
      log("current: $current");
      log("resizing: $resizeBackendOperation");
      if(
      resizeBackendOperation.isContiguousWith(current) && (
          resizeBackendOperation.operation == current.operation ||
              (
                  resizeBackendOperation.operation == OperationType.add &&
                      current.operation == OperationType.nothing
              )
      )
      ){
        resizeBackendOperation.endDate = current.endDate;
        log("Se mezcla: $resizeBackendOperation");
        //log("[$i] resized es ahora--->$resizeBackendOperation");
        toRemove.add(current);
      }
      else{
        log("NO Se mezcla: $resizeBackendOperation");

        resizeBackendOperation = mergedBackendOperations[i];
      }
    }
    //log(toRemove.toString());
    for(var backendOperation in toRemove){
      mergedBackendOperations.remove(backendOperation);
    }
    log("[-BACKEND OPERATIONS COMPRESSED-]\n $mergedBackendOperations");
    log("[-BACKEND OPERATIONS-]\n $backendOperations");
    return mergedBackendOperations;
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

  void add(DateTime date, OperationType operation, int publication){

    if(!backendOperationContains(date))
    {
      log("Añadiendo a backend operations ---------$date");
      var backendOperation  = BackendOperation(date,
          date.add(Config.minTimeOfReservation - const Duration(minutes: 1)),
          operation,publication);
      backendOperations.add(backendOperation);
    }
    else{
      int i = backendOperationsIndexOf(date);
      if(backendOperations[i].operation == OperationType.nothing) {
        backendOperations[i].operation = operation;
      }
      else if(backendOperations[i].operation == OperationType.delete){
        backendOperations[i].operation = OperationType.nothing;
      }
      else{
        backendOperations.removeAt(i);
      }
    }
    log("[-Backend Operations-]\n $backendOperations");
  }

  BackendOperations(List<DateTime> reservations,int publication){
    for(var reservation in reservations){
      add(reservation, OperationType.nothing, publication);
    }
  }
//TODO: posible refactor
  bool resultOfApplyingIsAContiguousReservation() {

    List mergedOperations =  mergeBackendOperations();

    //log("Comprobando si las horas de la reserva son contiguas\n\n\n");
    var lastOperation;
    int i=0;
    for (var operation in mergedOperations) {
      if(operation.operation == OperationType.nothing ||
          operation.operation == OperationType.add){
        lastOperation = operation;
        break;
      }
      ++i;
    }
    //log("Primera reserva: ${lastOperation.toString()}");
    if(lastOperation==null) {
      //log("pal carrer");
      return true;
    }
    if(++i >= mergedOperations.length) return true;
    //log("pasamos al algoritmo de comprobacion");
    while ( i < mergedOperations.length ){
      if(mergedOperations[i].operation != OperationType.delete){
        /*  log("___________________________________");
        log("COMPARE--> $lastOperation  / ${mergedOperations[i]}");
        log("\nis contiguos------- ${lastOperation.isContiguousWith(mergedOperations[i])}")*/;
        if(!lastOperation.isContiguousWith(mergedOperations[i])) {
          //log("----no----");
          return false;
        }
        else{
          //log("----si----");
        }
        lastOperation = mergedOperations[i];
      }
      i+=1;
    }
    return true;
  }

  int getNumberOfOperationsOfType(OperationType op){
    int reservations=0;
    for(var operation in backendOperations){
      if(operation.operation == op) ++reservations;
    }
    return reservations;
  }

  int getNumberOfNewReservations() {
    int reservations=0;
    for(var operation in backendOperations){
      if(operation.operation == OperationType.add) ++reservations;
    }
    return reservations;
  }

  int getNumberOfOperations() {
    return backendOperations.length;
    int reservations=0;
    for(var operation in backendOperations){
      if(operation.operation != OperationType.nothing)
        ++reservations;
    }
    return reservations;
  }

  void reset() {
    backendOperations = [];
  }
}

class BackendOperation{
  late DateTime startDate;
  late DateTime endDate;
  late int publication;
  late OperationType operation;
  var repetitionMode;

  bool contains(DateTime date){
    return ( date >= startDate && date < endDate );
  }

  bool isContiguousWith(BackendOperation b){
    bool contiguous = endDate.difference(b.startDate).inMinutes.abs() <= Config.minTimeOfReservation.inMinutes;
    //log("iscontigousu ---->diference ${endDate.difference(b.startDate).inMinutes.abs()} <= ${Config.minTimeOfReservation.inMinutes} | ${(contiguous)?"Si":"No"}");

    return contiguous;
  }

  Future<bool> execute() async {
    Map<String, dynamic> data = {};
    data['publication'] = publication.toString();
    data['start_date'] = startDate.toString();
    data['end_date'] = endDate.toString();
    if(operation == OperationType.block) {
      data['repeat_mode'] = repetitionMode.toString();
      bool res = await PublicationService.blockRangeOfHours(data);
      log("a ver si es nula la publicaicon -----ñ"+res.toString());
      return res;
    }

    return await BookingService.newBooking(data);
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

  BackendOperation(this.startDate, this.endDate, this.operation, this.publication);

  BackendOperation clone(){

    return BackendOperation(
        startDate,
        endDate,
        operation,
        publication);
  }
}
