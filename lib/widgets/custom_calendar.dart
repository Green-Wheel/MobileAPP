import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';



class customCalendar extends StatefulWidget {
  var time=0;
  final Function get_selected_date;
  customCalendar({Key? key,required this.get_selected_date}) : super(key: key);

  @override
  _customCalendarState createState() => _customCalendarState();
}

class _customCalendarState extends State<customCalendar> {
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: selectedDate,
      firstDay:  DateTime.utc(2021, 1, 1),
      lastDay:   DateTime.utc(DateTime.now().year+10,1,1),
      headerStyle: HeaderStyle(
        titleTextStyle:
        const TextStyle(fontSize: 20.0, color:Color(0xc0052e42)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0))),
        formatButtonTextStyle:
        const TextStyle(color: Colors.green, fontSize: 16.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.green
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(500.0),

          ), ),
        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: Colors.green,
          size: 28,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: Colors.green,
          size: 28,
        ),
      ),
      calendarStyle: CalendarStyle(
        // Weekend dates color (Sat & Sun Column)
        weekendTextStyle: TextStyle(color: Colors.green),
        // highlighted color for today
        todayDecoration: BoxDecoration(

          color: Color(0xf0052e42),
          border: Border.all(
            color: Colors.blueGrey,
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
        // highlighted color for selected day
        selectedDecoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = DateTime(selectedDay.year,selectedDay.month,selectedDay.day);// update `_focusedDay` here as well
          widget.get_selected_date(selectedDate);
        });
      },

      onPageChanged: (focusedDay) {
        //selectedDate = focusedDay;
      },

  );

  }
}