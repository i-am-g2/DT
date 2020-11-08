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
  TextStyle cstyle =
      TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 20);
  Future<DataBalance> dataBalance = fetchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 45, 45),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Today's Data Usage ", style: cstyle),
            SizedBox(height: 10),
            FutureBuilder<DataBalance>(
                future: dataBalance,
                builder: (context, AsyncSnapshot<DataBalance> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.today, style: cstyle);
                  } else {
                    return Text("", style: cstyle);
                  }
                }),
            SizedBox(height: 30),
            Text(
              "Total Data Usage ",
              style: cstyle,
            ),
            SizedBox(height: 10),
            FutureBuilder<DataBalance>(
                future: dataBalance,
                builder: (context, AsyncSnapshot<DataBalance> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.total, style: cstyle);
                  } else {
                    return Text("", style: cstyle);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
