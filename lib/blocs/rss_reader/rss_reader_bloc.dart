import 'package:rxdart/rxdart.dart';

import 'package:flutter_app_demo/common/constants.dart';
import 'package:flutter_app_demo/blocs/rss_reader/web_launch.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderBloc {
  /* ------------------------------------------------------------ *
   * Field
   * ------------------------------------------------------------ */

  // 記事を取得する
  final _feedItemsController = BehaviorSubject<List<Map<String, dynamic>>>.seeded(FEEDS.feedItemList);
  Sink<List<Map<String, dynamic>>> get feedItemsSink => _feedItemsController.sink;
  Stream<List<Map<String, dynamic>>> get feedItems => _feedItemsController.stream;

  final _articlesController = PublishSubject<List<Article>>();
  Sink<List<Article>> get articlesSink => _articlesController.sink;
  Stream<List<Article>> get articles => _articlesController.stream;

  dispose() {
    _articlesController.close();
    _feedItemsController.close();
  }

  /* ------------------------------------------------------------ *
   * Constructor
   * ------------------------------------------------------------ */
  RssReaderBloc();

  /* ------------------------------------------------------------ *
   * Method
   * ------------------------------------------------------------ */
  void launch(String url) async {
    articlesSink.add(await WebLaunch().getArticles(url));
  }
}
