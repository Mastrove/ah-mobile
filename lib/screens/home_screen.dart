// Framework
import 'package:ah_mobile/components/user_drawer_header.dart';
import 'package:ah_mobile/models/auth.dart';
import 'package:flutter/material.dart';

// Local imports
import 'package:ah_mobile/components/hero_section.dart';
import 'package:ah_mobile/components/tabbed_nav.dart';
import 'package:ah_mobile/components/signup_drawer_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            !auth.isAuthenticated ? SignUpDrawerHeader() : UserDrawerHeader(),
            Expanded(
              flex: 2,
              child: ListView(),
            )
          ],
        ),
      ),
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
