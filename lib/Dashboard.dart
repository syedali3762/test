import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold3 = Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Management App",
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            //day cahnged
            onDaySelected: (DateTime selectday, DateTime foucsDay) {
              setState(() {
                selectDay = selectday;
                focusedDay = foucsDay;
              });
              print(foucsDay);
            },
            selectedDayPredicate: (DateTime Date) {
              return isSameDay(selectDay, Date);
            },

            eventLoader: _getEventsfromDay,

            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle:
                  TextStyle(color: Color.fromARGB(255, 201, 181, 181)),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
              // leftChevronVisible: false,
              // rightChevronVisible: false,
              // headerPadding:
              //     EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            ),
          ),
          ..._getEventsfromDay(selectDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Add Event"),
                  content: TextFormField(controller: _eventController),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel")),
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        if (_eventController.text.isEmpty) {
                        } else {
                          if (selectedEvents[selectDay] != null) {
                            selectedEvents[selectDay]?.add(
                              Event(title: _eventController.text),
                            );
                          } else {
                            selectedEvents[selectDay] = [
                              Event(title: _eventController.text)
                            ];
                          }
                        }
                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {});
                        return;
                      },
                    ),
                  ],
                )),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;

    //  SfCalendar(
    //   view: CalendarView.week,
    //   firstDayOfWeek: 6,
    //   initialDisplayDate: DateTime(2022, 03, 01, 08, 30),
    //   initialSelectedDate: DateTime(2022, 03, 01, 08, 30),
    //   dataSource: MeetingDatasource(getAppointments()),
    // ),
    // );
  }
}

//  List<Appointment> getAppointments() {
//   List<Appointment> meetings = <Appointment>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));

  // meetings.add(Appointment(
//       startTime: startTime,
//       endTime: endTime,
//       subject: 'conference',
//       color: Colors.blue,
//       recurrenceRule: 'FREQ=DAILY; COUNT=10'));
//   return (meetings);
// }

//  class MeetingDatasource extends CalendarDataSource {
//   MeetingDatasource(List<Appointment> source) {
//     appointments = source;
//   }
// }
