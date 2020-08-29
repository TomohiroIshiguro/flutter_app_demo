import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_demo/views/rss_reader/rss_reader_view.dart';

class NavigationBar extends StatefulWidget {
  final List<Map<String, dynamic>> pages = [
    {
      "label": BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('Feed')),
      "page": RssReaderView()
    },
    {
      "label": BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('Blank')),
      "page": Container()
    }
  ];

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> pageList = [];
    widget.pages.forEach((el) {pageList.add(el["label"]);});
    return Scaffold(
      body: widget.pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        items: pageList,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
