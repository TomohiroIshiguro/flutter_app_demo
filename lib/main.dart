import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app_demo/views/navigation_bar.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/top': (_) => new NavigationBar(),
    },
    theme: ThemeData(
      // アプリケーション全体のテーマを規定する
      brightness: Brightness.light,
      primaryColor: Color(0xFF58AB34),
      accentColor: Color(0xFFF4F4F4),
      backgroundColor: Color(0xFFF4F4F4),
    ),
  ));
}

// ---------
// スプラッシュ
// ---------
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // TODO: スプラッシュアニメーション
        child: const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 指定した秒が経過したら次の画面に移る
    new Future.delayed(const Duration(seconds: 3))
        .then((value) => _nextPage());
  }

  void _nextPage() {
    Navigator.of(context).pushReplacementNamed("/top");
  }
}
