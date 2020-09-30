import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app_demo/views/commons/version_view.dart';
import 'package:flutter_app_demo/views/commons/terms_of_usage_view.dart';
import 'package:flutter_app_demo/views/commons/licences_view.dart';

class SideDrawer extends Drawer {
  final List<Map<String, dynamic>> drawMenu = [
    {
      "icon": Icons.help,
      "label": const Text('Version'),
      "page": new VersionView()
    },
    {
      "icon": Icons.border_all,
      "label": const Text('Terms of usage'),
      "page": new TermsOfUsageView()
    },
    {
      "icon": Icons.list,
      "label": const Text('Licences'),
      "page": new LicencesView()
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: drawMenu.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:Icon(this.drawMenu[index]['icon']),
            title: this.drawMenu[index]['label'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => this.drawMenu[index]['page']),
              );
            },
          );
        },
      ),
    );
  }
}