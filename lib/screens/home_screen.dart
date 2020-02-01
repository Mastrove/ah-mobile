// Framework
import 'package:flutter/material.dart';

// Local imports
import 'package:ah_mobile/components/hero_section.dart';
import 'package:ah_mobile/components/tabbed_nav.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeroSection(),
            TabbedNav(),
          ],
        ),
      ),
    );
  }
}
