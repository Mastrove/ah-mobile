import 'package:flutter/material.dart';

import 'package:ah_mobile/screens/home_screen.dart';
import 'package:ah_mobile/provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProvidedApp(
      child: MaterialApp(
        title: "Authors' Haven",
        home: HomeScreen(),
      ),
    );
  }
}
