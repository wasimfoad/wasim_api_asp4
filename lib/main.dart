  import 'package:flutter/material.dart';
  import 'Tasks.dart';
  import 'Notes.dart';
  import 'Contacts.dart';
  import 'Appointments.dart';
  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: MainScreen());
    }
  }

  class MainScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home:  DefaultTabController(
            initialIndex: 0,
            length: 4,

            child: Scaffold(
                appBar: AppBar(
                  title:
                  Text('Wasim Flutter Book'),
                  bottom: TabBar(
                         indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50), // Creates border
                          color: Colors.blueGrey), //Change background color from here
                    tabs: <Widget>[
                      Tab(text:'Appointments',icon: Icon(Icons.calendar_view_day)),
                      Tab(text:'Contacts',icon: Icon(Icons.people)),
                      Tab(text:'Notes',icon: Icon(Icons.note)),
                      Tab(text:'Tasks',icon: Icon(Icons.done)),
                    ],
                  ),
                ),
                body:
                TabBarView(
                    children: <Widget>[
                      Center(child: Text('It\'s cloudy here')),
                      Center(child: Text('It\'s rainy here')),
                      Center(child: Text('It\'s sunny here') ),
                      Center(child: Text('It\'s sunny here') ),
                    ]
                )
            )
        ),

      );
    }
  }
