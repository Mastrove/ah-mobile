import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Authors' Haven",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Authors' Haven"),
        ),
        body: Center(
          child: Text("Welcome to Authors' Haven"),
        ),
      ),
    );
  }
}
