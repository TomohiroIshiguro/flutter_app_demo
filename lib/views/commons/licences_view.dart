import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LicencesView extends StatelessWidget {
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
        title: const Text("ライセンス",
            style: TextStyle(
                fontSize: 20
            )
        )
    );
  }

  // ビューのbody
  Widget _buildBody(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      new Text("・xxxコンポーネント : xxxxxx社の利用規約の範囲内で使用する。"),
      new Text(""),
      new Text("Copyright 2020 Tomohiro Ishiguro. All rights researved."),
    ],);
  }
}