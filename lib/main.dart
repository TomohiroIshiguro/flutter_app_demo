import 'dart:async';

import 'package:flutter/material.dart';

import 'blocs/rss_reader/rss_reader_bloc.dart';
import 'views/rss_reader/rss_reader_view.dart';

void main() {

  RssReaderBloc rssReaderBloc = RssReaderBloc();

  runApp(new MaterialApp(
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/home': (_) => new RssReaderView(bloc:rssReaderBloc),
    },
    theme: ThemeData(
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

    new Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  void handleTimeout() {
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
