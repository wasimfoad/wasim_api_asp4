import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Center(
      child: FutureBuilder(
          future: http.get(Uri.parse('https://reqres.in/api/users')),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return CircularProgressIndicator();
            if (snapshot.hasError) return Text('Oh no! Error! ${snapshot.error}');
            if (!snapshot.hasData) return Text('Nothing to show');

            int statusCode =snapshot.data.statusCode ;
            if (statusCode > 299) return Text('Server error: $statusCode');

            Map userData = json.decode(snapshot.data.body);
            List _users = userData["data"];
            print(_users);
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return MyCkeck(myTitle:_users[index]['first_name'] + " " + _users[index]['last_name'],
                    mySubTitle:_users[index]['email'],
                ) ;






               /*return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(_users[index]['avatar'])),
                  title: Text(_users[index]['first_name'] + " " + _users[index]['last_name']),
                  subtitle: Text(_users[index]['email']),
                );*/
              },
            );
          }
      ),
    );
  }
}
class MyCkeck extends StatefulWidget {
 // List<dynamic> data=[];
 /* MyCkeck(List<dynamic> outerData){
    data=outerData;
  }*/
  final String? myTitle;
  final String? mySubTitle;
  MyCkeck({Key? key, @required this.myTitle, @required this.mySubTitle}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyCkeck> {

  bool? _isChecked = false;
  @override

  Widget build(BuildContext context) {

    return

           CheckboxListTile(
            value:  _isChecked,
            title:   Text(widget.myTitle.toString()),
            subtitle: Text(widget.mySubTitle.toString()),
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value;
              });
            },
        );

  }
}
