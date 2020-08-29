import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_demo/views/rss_reader/rss_reader_view.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  var bottomItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text('Feed')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text('Blank')),
  ];

  Widget _buildCurrentPage(int _selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        return RssReaderView();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
