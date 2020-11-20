import 'dart:io';
import 'req.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var errorText = "Make sure you are connected to BSNL Wifi and try again!";
  var cstyle =
      TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 20);
  var estyle =
      TextStyle(color: Color.fromARGB(255, 150, 150, 150), fontSize: 16);
  var dataBalance = fetchData();

  void _refresh() {
    setState(() {
      dataBalance = null;
      dataBalance = fetchData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 45, 45),
      body: Center(
        child: FutureBuilder<DataBalance>(
          future: dataBalance,
          builder: (context, AsyncSnapshot<DataBalance> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.valid == true) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Today's Data Usage ", style: cstyle),
                    SizedBox(height: 10),
                    Text(
                      snapshot.data.today,
                      style: cstyle,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Total Data Usage ",
                      style: cstyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      snapshot.data.total,
                      style: cstyle,
                    ),
                  ],
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    errorText,
                    style: estyle,
                  ),
                );
              }
            } else {
              return Text(
                "Loading... ",
                style: cstyle,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _refresh, child: Icon(Icons.refresh),),
    );
  }
}
