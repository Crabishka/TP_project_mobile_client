import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ProductCalendar extends StatefulWidget {
  const ProductCalendar({super.key});

  @override
  _ProductCalendarState createState() => _ProductCalendarState();
}

class _ProductCalendarState extends State<ProductCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> getTimeFromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _focusedDay = prefs.get('selected_date') == null
          ? DateTime.now()
          : DateTime.parse(prefs.get('selected_date').toString());
    });
  }

  @override
  void initState()  {
    getTimeFromShared();
    print(_focusedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 14)),
      currentDay: _focusedDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) async {
        _focusedDay = focusedDay;
        if (!isSameDay(_selectedDay, selectedDay)) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('selected_date', selectedDay.toIso8601String());
          setState(() {
            _focusedDay = selectedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      enabledDayPredicate: (day) {
        return day.isAfter(DateTime.now().subtract(Duration(days: 1)));
      },
    );
  }
}
