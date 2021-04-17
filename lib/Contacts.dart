import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String con='http://192.168.1.106/WebApplication1/api/ContactsJsonApi';
    String xcon='https://reqres.in/api/users';
String imgPath='http://192.168.1.106/WebApplication1/img/';
    return Center(
      child: FutureBuilder(



          future: http.get(Uri.parse(con)),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return CircularProgressIndicator();
            if (snapshot.hasError) return Text('Oh no! Error! ${snapshot.error}');
            if (!snapshot.hasData) return Text('Nothing to show');

            int statusCode =snapshot.data.statusCode ;
            if (statusCode > 299) return Text('Server error: $statusCode');

            //Map userData = json.decode(snapshot.data.body);
           // List _users = userData["data"];
            List _users =json.decode(snapshot.data.body);
            print(_users);
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage( imgPath +_users[index]['avatar'])),
                  title: Text(_users[index]['firstName'].toString() + " " + _users[index]['lastName'].toString()),
                  subtitle: Text(_users[index]['email'].toString()),
                );
              },
            );
          }
      ),
    );
  }
}
