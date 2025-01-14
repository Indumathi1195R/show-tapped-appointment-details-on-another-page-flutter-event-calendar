import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(TappedDetails());

class TappedDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentDetails(),
    );
  }
}

class AppointmentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Route'),
        ),
        body: SfCalendar(
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
            CalendarView.schedule
          ],
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          onTap: calendarTapped,
          dataSource: _getCalendarDataSource(),
        ));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Appointment appointment = calendarTapDetails.appointments[0];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute(appointment:appointment)),
      );
    }
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 2)),
      subject: 'Meeting',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 3)),
      endTime: DateTime.now().add(Duration(hours: 4)),
      subject: 'Planning',
      color: Colors.orange,
    ));
    return _AppointmentDataSource(appointments);
  }
}

class SecondRoute extends StatelessWidget {
  Appointment appointment;

  SecondRoute({this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        children: [
          Divider(color: Colors.white,),
          Center(
            child: Text(
              appointment.subject,
            ),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(appointment.startTime,).toString()),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(appointment.endTime,).toString()),
          ),
        ],
      ),
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
