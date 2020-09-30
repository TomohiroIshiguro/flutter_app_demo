import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TermsOfUsageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).popUntil(ModalRoute.withName("/top"));
        return null;
      },
      child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
          backgroundColor: Theme.of(context).backgroundColor
      ),
    );
  }

  // ビューのappBar(画面上部)
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text("利用規約",
            style: TextStyle(
                fontSize: 20
            )
        )
    );
  }

  // ビューのbody
  Widget _buildBody(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      new Text("1. 本アプリの目的"),
      new Text("本アプリは、モバイルアプリを開発する際にFlutterを使うことを提案するために使用します。"),
    ],);
  }
}
