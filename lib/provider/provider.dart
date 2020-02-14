import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidedApp extends StatelessWidget {
  final Widget child;

  ProvidedApp({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: child,
    );
  }
}
