import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name1;
  String email1;
  String imgUrl1;

  String name2;
  String email2;
  String imgUrl2;

  void fetchalldatas() async {
    await fetchData1();
    await fetchData2();
  }

  void fetchData1() async {
    var response = await http.get("https://reqres.in/api/users/2");
    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        name1 = data['data']['first_name'];
        email1 = data['data']['email'];
        imgUrl1 = data['data']['avatar'];
      });
    }
  }

  void fetchData2() async {
    var response = await http.get("https://reqres.in/api/users/1");
    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      var data = jsonDecode(response.body);
      print(data);

      setState(() {
        name2 = data['data']['first_name'];
        email2 = data['data']['email'];
        imgUrl2 = data['data']['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple APIs"),
        centerTitle: true,
      ),
      body: Container(
        width: 400,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white70,
              Colors.lightBlueAccent[100],
              Colors.white70
            ], stops: [
              0.2,
              0.7,
              0.9
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            FlatButton(
              color: Colors.orangeAccent,
              child: Text("Fetch Data"),
              onPressed: () {
                // call api
                fetchalldatas();
              },
            ),
            SizedBox(
              height: 50,
            ),
            name1 == null
                ? Text("data 1 will appear here")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(imgUrl1), fit: BoxFit.cover),
                        ),
                        child: null,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name1,
                            textScaleFactor: 1.7,
                          ),
                          Text(email1),
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: 50,
            ),
            name2 == null
                ? Text("data 2 will appear here")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(imgUrl2), fit: BoxFit.cover),
                        ),
                        child: null,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name2,
                            textScaleFactor: 1.7,
                          ),
                          Text(email2),
                        ],
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
