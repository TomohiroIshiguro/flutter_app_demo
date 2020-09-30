import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_demo/views/rss_reader/rss_reader_view.dart';
import 'package:flutter_app_demo/views/qrcode_reader/qrcode_reader_view.dart';

class NavigationBar extends StatefulWidget {
  final List<Map<String, dynamic>> pages = [
    {
      "label": BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home), title: const Text('Feed')),
      "page": new RssReaderView()
    },
    {
      "label": BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.photo_camera), title: const Text('QR Code')),
      "page": new QrCodeReaderView()
    },
    {
      "label": BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home), title: const Text('Blank')),
      "page": new Container()
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
