import 'package:academia/widgets/events_widget.dart';
import 'package:academia/widgets/task_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 16),
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  rightChevronIcon: Icon(CupertinoIcons.arrow_right),
                  leftChevronIcon: Icon(CupertinoIcons.arrow_left),
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(color: Colors.grey),
                  todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue,
                  ),
                ),
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: ListView(
                  children: [
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),

                    // school events
                    EventCard(),

                    // Dita's Event Card
                    EventCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
