import '../configs/confirm_bookings_config.dart';

String cutDownString(var s){
  if(s==null) return "";
  if(s.toString().length <= ConfirmAndHistoryConfig.maxTitleCaracters) return " "+s;
  return " "+s.substring(0,ConfirmAndHistoryConfig.maxTitleCaracters)+"...";
}

String cutDownStringName(var s){
  if(s==null) return "";
  if(s.toString().length <= 15) return " "+s;
  return " "+s.substring(0,15)+"..";
}