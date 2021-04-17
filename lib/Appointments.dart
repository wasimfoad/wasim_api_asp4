import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
class appointmentsScreen extends StatefulWidget {
  @override
  _appointmentsScreenState createState() => _appointmentsScreenState();
}

class _appointmentsScreenState extends State<appointmentsScreen> {
  @override

 Widget build(BuildContext context) {
   return Center(
     child: FutureBuilder(
          future: http.get(Uri.parse('https://reqres.in/api/users')),
         //future: http.get(Uri.parse('https://reqres.in/api/users')),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return CircularProgressIndicator();
            if (snapshot.hasError) return Text('Oh no! Error! ${snapshot.error}');
            if (!snapshot.hasData) return Text('Nothing to show');

            int statusCode =snapshot.data.statusCode ;
            if (statusCode > 299) return Text('Server error: $statusCode');

            Map userData = json.decode(snapshot.data.body);
            List _users = userData["data"];
            //******TEST DATA ******///
            _users=[
              {"id":1,"subject":"Conference","startDate":"2/4/2021","endDate":"1/2/2021"},
              {"id":1,"subject":"Exam","startDate":"1/4/2021","endDate":"1/2/2021"},
              {"id":1,"subject":"Project","startDate":"16/4/2021","endDate":"1/2/2021"},
              {"id":1,"subject":"Meeting","startDate":"18/4/2021","endDate":"1/2/2021"},
            ];

            print(_users);
            /*
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {

                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(_users[index]['avatar'])),
                  title: Text(_users[index]['first_name'] + " " + _users[index]['last_name']),
                  subtitle: Text(_users[index]['email']),
                );

              },
            )*/
            return Scaffold(
                body: SfCalendar(
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(_getDataSource(_users)),
                  // by default the month appointment display mode set as Indicator, we can
                  // change the display mode as appointment using the appointment display
                  // mode property
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                )
            );
          }
      ),
   );



  }
/*
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        )
    );
  }
*/
  List<Meeting> _getDataSource(List<dynamic> data) {
    final List<Meeting> meetings = <Meeting>[];
    for (var i=0; i<data.length; i++) {
      String startDateS = data[i]['startDate'];
      DateTime startDate = DateTime.utc(int.parse(startDateS.split('/')[2]),
          int.parse(startDateS.split('/')[1]),
          int.parse(startDateS.split('/')[0])
      )  ;

      String endDateS = data[i]['startDate'];
      DateTime endDate = DateTime.utc(int.parse(startDateS.split('/')[2]),
          int.parse(endDateS.split('/')[1]),
          int.parse(endDateS.split('/')[0])
      )  ;



      meetings.add(Meeting(
          data[i]['subject'], startDate, endDate, const Color(0xFF0F8644), false));
    }


   // final DateTime today = DateTime.now();
    //final DateTime startTime =
   // DateTime(today.year, today.month, today.day, 9, 0, 0);
   // final DateTime endTime = startTime.add(const Duration(hours: 2));

    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

