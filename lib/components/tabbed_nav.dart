// Framework
import 'package:flutter/material.dart';

class TabbedNav extends StatefulWidget {
  @override
  _TabbedNavState createState() => _TabbedNavState();
}

class _TabbedNavState extends State<TabbedNav>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs;
  int _currentIndex = 0;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();

    tabs = ['Feed', 'Trending', 'Most Hyped'];
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabControllerTick);
  }

  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  _tabsContent() {
    if (_currentIndex == 0) {
      return Container(
        child: Text('one'),
      );
    } else if (_currentIndex == 1) {
      return Container(
        child: Text('two'),
      );
    } else if (_currentIndex == 2) {
      return Container(
        child: Text('three'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Todo: This widget may affect the pages scrolling scrolling
    // replace with ListView
    return Column(
      children: <Widget>[
        TabBar(
          labelStyle:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
          ),
          indicatorColor: Color(0xFF3C3A3A),
          labelColor: Color(0xFF3C3A3A),
          unselectedLabelColor: Color(0x8C3C3A3A),
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
        _tabsContent(),
      ],
    );
  }
}
