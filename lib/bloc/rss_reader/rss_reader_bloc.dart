import 'package:rxdart/rxdart.dart';

import 'package:flutter_app_demo/data_access/web_launch.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderBloc {
  /* ------------------------------------------------------------ *
   * Stream
   * ------------------------------------------------------------ */
  final _articlesController = PublishSubject<List<Article>>();
  Sink<List<Article>> get articlesSink =>
      _articlesController.sink;
  Observable<List<Article>> get articles =>
      _articlesController.stream;

  /* ------------------------------------------------------------ *
   * Field
   * ------------------------------------------------------------ */
  WebLaunch webLaunch = WebLaunch.getInstance();

  /* ------------------------------------------------------------ *
   * Constructor
   * ------------------------------------------------------------ */
  RssReaderBloc() {}

  /* ------------------------------------------------------------ *
   * Method
   * ------------------------------------------------------------ */
  void launch(String url) async {
    articlesSink.add(await webLaunch.getArticles(url));
  }

  dispose() {
    _articlesController.close();
  }
}
