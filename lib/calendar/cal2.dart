import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../app_screen/diaryFix.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen>
    with AutomaticKeepAliveClientMixin {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = {
      "2023-04-13": [
        {"eventDescp": "Submit", "eventTitle": "LAB 12"},
        {"eventDescp": "Project", "eventTitle": "Present"}
      ],
      "2023-04-30": [
        {"eventDescp": "Project", "eventTitle": "Present"}
      ],
      "2023-04-20": [
        {"eventDescp": "Project", "eventTitle": "Present"}
      ]
    };
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(titleController.text);
                print(descpController.text);

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                      }
                    ];
                  }
                });

                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 222, 186, 1),
        centerTitle: true,
        title: const Text(
          'Calendar',
          style: const TextStyle(
            color: Color.fromRGBO(71, 60, 51, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(71, 60, 51, 1),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Color.fromRGBO(169, 144, 126, 1),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black12,
                      offset: Offset(0, 5)),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.only(bottom: 30),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  focusedDay: _focusedDay,
                  rowHeight: 50,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  calendarFormat: _calendarFormat,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDate, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                  eventLoader: _listOfDayEvents,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Column(
                children: [
                  ..._listOfDayEvents(_selectedDate!).map(
                    (myEvents) => Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          leading: const Icon(
                            Icons.done,
                            color: Colors.teal,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                                'Event Title:   ${myEvents['eventTitle']}'),
                          ),
                          subtitle:
                              Text('Description:   ${myEvents['eventDescp']}'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
        backgroundColor: Color.fromRGBO(
            71, 60, 51, 1), // Change the background color to blue
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
