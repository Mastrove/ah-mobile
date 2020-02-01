import 'package:ah_mobile/store/store.dart';
import 'package:ah_mobile/widgets/signup-form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Authors' Haven",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Authors' Haven"),
          ),
          body: Center(child: SignUpForm()),
        ),
      ),
    );
  }
}
