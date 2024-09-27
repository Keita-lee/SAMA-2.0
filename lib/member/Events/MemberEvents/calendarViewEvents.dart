import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sama/commonColors/SamaColors.dart';
import 'package:sama/components/myutility.dart';
import 'package:table_calendar/table_calendar.dart';

import 'MemberEventsComp/desktopViewDetailsPopup.dart';
import 'MemberEventsComp/eventViewDeatilsButton.dart';

class CalendarViewEvents extends StatefulWidget {
  const CalendarViewEvents({super.key});

  @override
  State<CalendarViewEvents> createState() => _CalendarViewEventsState();
}

class _CalendarViewEventsState extends State<CalendarViewEvents> {
  DateTime today = DateTime.now();
  Map<DateTime, List<String>> events = {};

  @override
  void initState() {
    super.initState();

    events = {
      DateTime(2024, 9, 25): ['Event 1', 'Event 2'],
      DateTime(2024, 9, 26): ['Event 3'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime day, DateTime focusday) {
    setState(() {
      today = day;
    });

    bool isMobile = MyUtility(context).width < 600;

    if (!isMobile && _getEventsForDay(day).isNotEmpty) {
      // Show popup for desktop
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.none,
            child: DesktopViewDetailsPopup(),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    return Transform.scale(
      scale: isMobile == true ? 1 : 1.2,
      child: Column(
        children: [
          Container(
            width: 600,
            child: TableCalendar(
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, day, focusedDay) {
                  final date = DateFormat('dd').format(focusedDay);
                  final weekDay = DateFormat.E().format(day);
                  return Padding(
                    padding: EdgeInsets.only(bottom: isMobile == true ? 6 : 6),
                    child: Container(
                      width: isMobile == true ? 50 : 70,
                      height: isMobile == true ? 55 : 68,
                      decoration: BoxDecoration(
                          color: SamaColors().teal,
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: isMobile == true
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isMobile == true
                                      ? FontWeight.normal
                                      : FontWeight.w700,
                                  fontSize: isMobile == true ? 16 : 18),
                            ),
                            Text(
                              weekDay,
                              style: GoogleFonts.openSans(
                                  height: 0.8,
                                  color: Colors.white,
                                  fontWeight: isMobile == true
                                      ? FontWeight.normal
                                      : FontWeight.w200,
                                  fontSize: isMobile == true ? 16 : 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                markerBuilder: (context, day, events) {
                  if (_getEventsForDay(day).isNotEmpty) {
                    return Positioned(
                      bottom: 15,
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.teal),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
              focusedDay: today,
              firstDay: DateTime(2020),
              lastDay: DateTime.utc(2030, 12, 30),
              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay, // Load events for each day
              daysOfWeekStyle: DaysOfWeekStyle(),
              rowHeight: isMobile == true ? 67 : 80,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: isMobile == true ? 17 : 22
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        isMobile == true ? FontWeight.normal : FontWeight.w700,
                    fontSize: isMobile == true ? 16 : 18),
                weekendTextStyle: TextStyle(
                    fontWeight:
                        isMobile == true ? FontWeight.normal : FontWeight.w700,
                    fontSize: isMobile == true ? 16 : 18),
                outsideTextStyle: TextStyle(
                    fontWeight:
                        isMobile == true ? FontWeight.normal : FontWeight.w700,
                    fontSize: isMobile == true ? 16 : 18),
                selectedDecoration: BoxDecoration(color: SamaColors().teal),
                todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        isMobile == true ? FontWeight.normal : FontWeight.w700,
                    fontSize: isMobile == true ? 16 : 18),
                defaultTextStyle: TextStyle(
                    fontWeight:
                        isMobile == true ? FontWeight.normal : FontWeight.w700,
                    fontSize: isMobile == true ? 16 : 18),
                rangeHighlightColor: SamaColors().teal,
                todayDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color.fromRGBO(0, 159, 159, 0.568),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          isMobile
              ? Container(
                  width: MyUtility(context).width * 0.95,
                  height: MyUtility(context).height / 3 - 40,
                  child: ListView(
                    children: _getEventsForDay(today)
                        .map((event) => EventViewDeatailsButton(
                              eventName: event,
                              eventDate:
                                  DateFormat('dd MMMM yyyy').format(today),
                              eventTime: '18:00', // Dummy time
                              onTap: () {
                                // Define the onTap functionality for the event

                                print('Event Details tapped for $event');
                              },
                            ))
                        .toList(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
