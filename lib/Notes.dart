import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
   return Center(
      child: FutureBuilder(
          future: http.get(Uri.parse('https://reqres.in/api/users')),
         // future: http.get(Uri.parse('https://192.168.1.106/api/ContactsJsonAPI')),

      builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState != ConnectionState.done) return CircularProgressIndicator();
      if (snapshot.hasError) return Text('Oh no! Error! ${snapshot.error}');
      if (!snapshot.hasData) return Text('Nothing to show');

      int statusCode =snapshot.data.statusCode ;
      if (statusCode > 299) return Text('Server error: $statusCode');

      /*Map userData = json.decode(snapshot.data.body);
      List _users = userData["data"];*/
      List _users =[{"id":1,"email":"wasim_foad@yahoo.com","firstName":"wasim","lastName":"foad","avatar":"https://localhost:44371/img/1.jpg"}];
      //print(_users);
      return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
      return Container(
        child: Card(
          margin: EdgeInsets.all(5),
          color: Colors.deepOrange,
          shadowColor: Colors.grey,

        //Text(_users[index]['first_name'] + " " + _users[index]['last_name']),

            child:
                Column (
                  children: [
                    Center(
                      heightFactor: 2,
                      child: Text(
                       // _users[index]['first_name'] + " " + _users[index]['last_name'] ,
                        _users[index]['firstName'] + " " + _users[index]['lastName'] ,

                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),

                    ),
                    Center(
                      heightFactor: 2,
                      child: Text(
                        _users[index]['email'] ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),

                    ),
                  ],

                )

          ),


      );
      },
      );
  }
  ),
    );
    
    
}
}
